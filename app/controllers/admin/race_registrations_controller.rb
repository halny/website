# encoding: UTF-8

class Admin::RaceRegistrationsController < AdminController

  before_filter :find_race
  before_filter :find_race_variants, only: [:index]

  def index
    respond_to do |format|
      format.html
      format.csv do
        filename = "#{@race.name}_#{@race_variant.name}_#{I18n.l(Time.now, format: :short)}.csv"
        export_csv(@race_variant.race_registrations, filename)
      end
    end
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
      @race_variant = @race.race_variants.find(params[:race_variant_id])
      @race_variants = [ @race_variant ]
    else
      @race_variants = @race.race_variants
    end
  end

  def export_csv(registrations, filename)
    content = RaceRegistration.to_csv(registrations)
    send_data content, :filename => filename
  end
end
