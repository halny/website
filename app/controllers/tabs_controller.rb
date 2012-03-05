class TabsController < ApplicationController

  def index
    if params[:search].present?
      @tabs = Tab.search do
        fulltext params[:search]
      end.results
    else
      @tabs = Tab.order("'tabs.from' DESC").all
    end
  end
end
