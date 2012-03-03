class PagesController < ApplicationController

  def show
    @page = Page.active.find params[:id]
  end
end
