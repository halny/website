# encoding: UTF-8

class Admin::RaceRegistrationsController < AdminController

  before_filter :find_race
  before_filter :find_race_variants, only: [:index]

  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_race
    @race = Race.find(params[:race_id])
  end

  def find_race_variants
    if params[:race_variant_id].present?
      @race_variants = [@race.race_variants.find(params[:race_variant_id])]
    else
      @race_variants = @race.race_variants
    end
  end
end
