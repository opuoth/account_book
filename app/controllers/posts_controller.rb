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
    @outgos = Budget.where(budget_type:0).select("date").group("date").sum(:price)
    @incomes = Budget.where(budget_type:1).select("date").group("date").sum(:price)
    @dates = Budget.joins(:category).select("categories.*").group("budgets.budget_type","budgets.date","categories.name").order(date: "ASC").sum(:price)
  end

  def date
    @date = params[:date]
    @outgos = Budget.where(date: params[:date]).where(budget_type:0).joins(:category).select("categories.*").group("categories.name").order(date: "ASC").sum(:price)
    @incomes = Budget.where(date: params[:date]).where(budget_type:1).joins(:category).select("categories.*").group("categories.name").order(date: "ASC").sum(:price)
  end

  def report
    #グラフデータの初期化
    gon.data1 = []
    gon.data2 = []
    #パイチャートの初期化
    label_out={}
    label_in={}
    Category.all.each do |son|
      if(son.budget_type==0)
        label_out[son.name]=0
      else
        label_in[son.name]=0
      end
    end
    gon.label_out=[]
    gon.label_in=[]
    gon.data_out=[]
    gon.data_in=[]
    d = Date.today
    str = d.strftime('%Y-%m-')
    d.day.times do |date|
      gon.data1 << Budget.where(date:str+(date+1).to_s,budget_type: 0).sum(:price)
      gon.data2 << Budget.where(date:str+(date+1).to_s,budget_type: 1).sum(:price)
      data_hash_out = Budget.where(date:str+(date+1).to_s,budget_type: 0).joins(:category).select("categories.*").group("categories.name").sum(:price)
      data_hash_in = Budget.where(date:str+(date+1).to_s,budget_type: 1).joins(:category).select("categories.*").group("categories.name").sum(:price)

      data_hash_out.each do |key,value|
        label_out[key]+=value
      end
      data_hash_in.each do |key,value|
        label_in[key]+=value
      end
    end
    label_out.each do |key,value|
      gon.label_out << key
      gon.data_out << value
    end
    label_in.each do |key,value|
      gon.label_in << key
      gon.data_in << value
    end
    gon.year = d.year
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

  def category
  end

  def add
    @category = Category.new(
      name: params[:name],
      budget_type: params[:type]
    )
    if @category.save
      redirect_to("/outgoing") if params[:type] == '0'
      redirect_to("/incoming") if params[:type] == '1'
    else
      render("posts/calender")
    end
  end

end
