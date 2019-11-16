class PostsController < ApplicationController
  def outgoing
  end

  def out
    @post=Post.new(
      memo: params[:memo],
      outgoing: params[:outgoing]
    )
    if @post.save
      redirect_to("/outgoing")
    else
      @error_message="支出を入力してください"
      render("posts/outgoing")
    end
  end

  def incoming
  end

  def in
    @post=Post.new(
      memo: params[:memo],
      incoming: params[:incoming]
    )
    if @post.save
      redirect_to("/outgoing")
    else
      @error_message="収入を入力してください"
      render("posts/incoming")
    end
  end

  def index
    @posts=Post.all.order(created_at: :desc)
    @sumout=0
    @sumin=0
    @posts.each do|post|
      if post.outgoing.present?
        @sumout+=post.outgoing
      end
      if post.incoming.present?
        @sumin+=post.incoming
      end
    end
  end

  def calendar
  end

  def report
  end

  def show
    @post=Post.find_by(id: params[:id])
  end

  def edit
    @post=Post.find_by(id: params[:id])
  end

  def destroy
    @post=Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end

  def update
    @post=Post.find_by(id: params[:id])
    @post.outgoing=params[:outgoing]
    @post.incoming=params[:incoming]
    @post.memo=params[:memo]
    if @post.save
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
end
