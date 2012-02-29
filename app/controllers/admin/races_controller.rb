# encoding: UTF-8

class Admin::RacesController < ApplicationController

  def index
    @races = Race.all
  end
end
