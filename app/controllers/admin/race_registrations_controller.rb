# encoding: UTF-8

class Admin::RaceRegistrationsController < AdminController

  before_filter :find_race
  before_filter :find_race_variant, except: [:index]
  before_filter :find_race_variants, only: [:index]
  before_filter :find_race_registration, only: [:edit, :update, :destroy]

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
    @race_registration = @race_variant.race_registrations.build
  end

  def create
    @race_registration = @race_variant.race_registrations.build(params[:race_registration])
    @race_registration.accessible = [:notes, :paid]

    if @race_registration.save
      redirect_to admin_race_race_variant_race_registrations_path(@race, @race_variant), notice: "Dodano nową osobę na rajd."
    else
      flash[:error] = "Popraw błędu w formularzu."
      render action: 'new'
    end
  end

  def edit
  end

  def update
    @race_registration.accessible = [:notes, :paid]
    if @race_registration.update_attributes(params[:race_registration])
      redirect_to admin_race_race_variant_race_registrations_path(@race, @race_variant), notice: "Zmiany zapisane."
    else
      flash[:error] = "Popraw błędu w formularzu."
      render action: 'edit'
    end
  end

  def destroy
    @race_registration.destroy
    redirect_to admin_race_race_variant_race_registrations_path(@race, @race_variant), notice: "Rejestracja na rajd usunięta."
  end

  private

  def find_race
    @race = Race.find(params[:race_id])
  end

  def find_race_variant
    @race_variant = @race.race_variants.find(params[:race_variant_id])
  end

  def find_race_variants
    if params[:race_variant_id].present?
      find_race_variant
      @race_variants = [ @race_variant ]
    else
      @race_variants = @race.race_variants
    end
  end

  def find_race_registration
    @race_registration = @race_variant.race_registrations.find(params[:id])
  end

  def export_csv(registrations, filename)
    content = RaceRegistration.to_csv(registrations)
    send_data content, :filename => filename
  end
end
