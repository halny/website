class TabsController < ApplicationController

  def index
    @tabs = Tab.order("'tabs.from' DESC").all
  end
end
