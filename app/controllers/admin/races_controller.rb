# encoding: UTF-8

class Admin::RacesController < AdminController

  def index
    @races = Race.all
  end
end
