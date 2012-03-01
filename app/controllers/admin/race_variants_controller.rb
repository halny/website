# encoding: UTF-8

class Admin::RaceVariantsController < AdminController

  before_filter :find_race
  before_filter :find_race_variant, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @race_variant = @race.race_variants.build
  end

  def create
    @race_variant = @race.race_variants.build(params[:race_variant])

    if @race_variant.save
      redirect_to admin_race_race_variants_path(@race), notice: "Dodano nowy wariant trasy."
    else
      flash[:error] = "Popraw błędy w formularzu."
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @race_variant.update_attributes(params[:race_variant])
      redirect_to admin_race_race_variants_path(@race_variant.race), notice: "Zmiany zapisane."
    else
      flash[:error] = "Popraw błędy w formularzu."
      render action: 'edit'
    end
  end

  def destroy
    @race_variant.destroy
    redirect_to admin_race_race_variants_path(@race_variant.race), notice: "Rajd został usunięty."
  end

  private

  def find_race
    @race = Race.find(params[:race_id])
  end

  def find_race_variant
    @race_variant = @race.race_variants.find(params[:id])
  end
end
