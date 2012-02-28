class RaceRegistrationsController < ApplicationController

  before_filter :authenticate_user!

  before_filter :find_race, only: [:new, :edit, :create, :update]
  before_filter :find_race_variant, only: [:new, :edit, :create, :update]

  def new
    @race_registration = @race_variant.race_registrations.build(email: current_user.try(:email))
  end

  def create
    @race_registration = @race_variant.race_registrations.build(params[:race_registration])

    if @race_registration.save
      redirect_to race_path(@race), notice: 'Race registration was successfully created.'
    else
      render action: "new"
    end
  end

  private

  def find_race
    @race = Race.find(params[:race_id])
  end

  def find_race_variant
    @race_variant = RaceVariant.find(params[:race_variant_id])
  end
end
