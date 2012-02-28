class RacesController < ApplicationController

  def index
    @races = Race.open_for_registration.all
  end

  def show
    @race = Race.find(params[:id])
  end
end
