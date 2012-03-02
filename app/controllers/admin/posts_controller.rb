# encoding: UTF-8

class Admin::PostsController < AdminController

  before_filter :find_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to admin_posts_path, notice: "Dodano nową wiadomość."
    else
      flash[:error] = "Popraw błędy w formularzu."
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(params[:post])
      redirect_to admin_posts_path, notice: "Zmiany zapisane."
    else
      flash[:error] = "Popraw błędy w formularzu."
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "Wiadomość została usunięta."
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end
end
