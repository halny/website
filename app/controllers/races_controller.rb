# encoding: UTF-8

class RacesController < ApplicationController

  def index
    @races = Race.open_for_registration.all

    @registrations = current_user.present? ? current_user.race_registrations.all : nil
  end
end
