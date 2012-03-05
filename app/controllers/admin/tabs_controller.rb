# encoding: UTF-8

class Admin::TabsController < AdminController

  before_filter :find_tab, only: [:edit, :update, :destroy]

  def index
    @tabs = Tab.all
  end

  def new
    @tab = Tab.new
  end

  def create
    @tab = Tab.new params[:tab]

    if @tab.save
      redirect_to admin_tabs_path, notice: "Dodano nową informację do pigułki."
    else
      flash[:error] = "Popraw błędy w formularzu."
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @tab.update_attributes params[:tab]
      redirect_to admin_tabs_path, notice: "Zmiany zapisane."
    else
      flash[:error] = "Popraw błędy w formularzu."
      render action: 'edit'
    end
  end

  def destroy
    @tab.destroy
    redirect_to admin_tabs_path, notice: "Informacja została usunięta z pigułki."
  end

  private

  def find_tab
    @tab = Tab.find params[:id]
  end
end
