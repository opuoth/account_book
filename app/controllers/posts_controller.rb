require "date"
class PostsController < ApplicationController
  def outgoing
    @out_categories = Category.where(budget_type: 0)
  end

  def out
    @post=Budget.new(
      date: params[:date],
      memo: params[:memo],
      price: params[:outgoing],
      budget_type: 0,
      category_id: params[:category]
    )
    if @post.save
      date = Date.strptime(@post.date.to_s,'%Y-%m-%d').to_time
      month=Month.find_by(year: date.year, month: date.month)
      month.outgo+=@post.price
      month.save
      redirect_to("/outgoing")
    else
      @error_message="支出を入力してください"
      render("posts/outgoing")
    end
  end

  def incoming
    @in_categories = Category.where(budget_type: 1)
  end

  def in
    @post=Budget.new(
      date: params[:date],
      memo: params[:memo],
      price: params[:incoming],
      budget_type: 1,
      category_id: params[:category]
    )
    if @post.save
      date = Date.strptime(@post.date.to_s,'%Y-%m-%d').to_time
      month=Month.find_by(year: date.year, month: date.month)
      month.income+=@post.price
      month.save
      redirect_to("/outgoing")
    else
      @error_message="収入を入力してください"
      render("posts/incoming")
    end
  end

  def index
    @posts=Budget.all.order(id: :desc)
    @sumOut=0
    @sumIn=0
    @posts.each do|post|
      if post.budget_type==0
        @sumOut+=post.price.to_i
      else
        @sumIn+=post.price.to_i
      end
    end
  end

  def calendar
  end

  def report
    gon.data1 = []
    gon.data2 = []
    d = Date.today
    str = d.strftime('%Y-%m-')
    d.day.times do |date|
      gon.data1 << Budget.where(date:str+(date+1).to_s,budget_type: 0).sum(:price)
      gon.data2 << Budget.where(date:str+(date+1).to_s,budget_type: 1).sum(:price)
    end
    gon.month = d.month
  end

  def show
    @post=Budget.find_by(id: params[:id])
    @category=Category.find_by(id: @post.category_id)
  end

  def edit
    @post=Budget.find_by(id: params[:id])
    @categories=Category.where(budget_type: @post.budget_type).pluck('name')
    @category=Category.find_by(id: @post.category_id)
  end

  def destroy
    @post=Budget.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end

  def update
    @post=Budget.find_by(id: params[:id])
    date = Date.strptime(@post.date.to_s,'%Y-%m-%d').to_time
    month=Month.find_by(year: date.year, month: date.month)
    @post.date = params[:date]
    if @post.budget_type==0
      month.outgo-=@post.price
      @post.price=params[:outgo].to_i
    else
      month.income-=@post.price
      @post.price=params[:income].to_i
    end
    @post.memo=params[:memo]
    @post.category_id=Category.find_by(name: params[:category_name]).id
    if @post.save
      date_update = Date.strptime(@post.date.to_s,'%Y-%m-%d').to_time
      month_update=Month.find_by(year: date_update.year, month: date_update.month)
      if @post.budget_type==0
        month_update.outgo+=@post.price
      else
        month_update.income+=@post.price
      end
      month.save
      month_update.save
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
end
