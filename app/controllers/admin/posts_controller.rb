# encoding: UTF-8

class Admin::PostsController < AdminController

  before_filter :find_post, only: [:edit, :update, :destroy, :post_to_facebook]
  before_filter :published_already?, only: [:post_to_facebook]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new(published_at: Date.today)
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

  def post_to_facebook
    access_token = Facebook::CONFIG['page_access_token']
    page_graph = Koala::Facebook::API.new access_token
    post_id = page_graph.put_wall_post @post.title, link: post_url(@post)
    if post_id.present?
      @post.update_attribute(:posted_to_facebook, true)
      redirect_to admin_posts_path, notice: "Opublikowano na Facebook'u"
    else
      redirect_to admin_posts_path, alert: "Nie udało się opublikować na Facebook'u"
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def published_already?
    redirect_to admin_posts_path, alert: "Wiadomość została opublikowana już wcześniej." if @post.posted_to_facebook?
  end
end
