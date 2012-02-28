# encoding: UTF-8

class RaceRegistrationsController < ApplicationController

  before_filter :authenticate_user!

  before_filter :find_race_variant, only: [:new, :edit, :create, :update]

  before_filter :check_if_possible, only: [:new, :create]

  def new
    @race_registration = @race_variant.race_registrations.build(email: current_user.email)
  end

  def create
    @race_registration = @race_variant.race_registrations.build(params[:race_registration])
    @race_registration.user = current_user

    if @race_registration.save
      redirect_to races_path, notice: 'Rejestracja na rajd zakończona sukcesem.'
    else
      render action: "new"
    end
  end

  private

  def find_race_variant
    @race_variant = RaceVariant.find(params[:race_variant_id])
  end

  def check_if_possible
    redirect_to @race, alert: "Brak miejsc na tej trasie." if @race_variant.no_places_left?
  end
end
