# encoding: UTF-8

class RaceRegistrationsController < ApplicationController

  before_filter :authenticate_user!

  before_filter :find_race_registration, only: [:edit, :update, :destroy]
  before_filter :user_can_edit?, only: [:edit, :update, :destroy]

  before_filter :find_race_variant, only: [:new, :create]
  before_filter :check_if_possible, only: [:new, :create]

  def new
    defaults = { email: current_user.email, name: current_user.name, lastname: current_user.lastname,
      is_student: current_user.is_student, is_member: current_user.is_member, telephone: current_user.telephone }
    @race_registration = @race_variant.race_registrations.build(defaults)
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

  def edit
  end

  def update
    if @race_registration.update_attributes(params[:race_registration])
      redirect_to races_path, notice: 'Edycja danych zakończona sukcesem.'
    else
      render action: "edit"
    end
  end

  def destroy
    @race_registration.destroy
    redirect_to races_path, notice: 'Rejestracja na rajd została anulowana.'
  end

  private

  def find_race_variant
    @race_variant = RaceVariant.find(params[:race_variant_id])
  end

  def find_race_registration
    @race_registration = RaceRegistration.find(params[:id])
  end

  def check_if_possible
    redirect_to @race, alert: "Brak miejsc na tej trasie." if @race_variant.no_places_left?
  end

  def user_can_edit?
    redirect_to races_path, alert: "Nie masz uprawnień do edycji!" unless @race_registration.user == current_user
  end
end
