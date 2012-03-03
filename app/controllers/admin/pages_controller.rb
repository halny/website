# encoding: UTF-8

class Admin::PagesController < AdminController

  before_filter :find_page, only: [:edit, :update, :destroy]

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])

    if @page.save
      redirect_to admin_pages_path, notice: "Dodano nową stronę."
    else
      flash[:error] = "Popraw błędy w formularzu."
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @page.update_attributes(params[:page])
      redirect_to admin_pages_path, notice: "Zmiany zapisane."
    else
      flash[:error] = "Popraw błędy w formularzu."
      render action: 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to admin_pages_path, notice: "Strona została usunięta."
  end

  private

  def find_page
    @page = Page.find(params[:id])
  end
end
