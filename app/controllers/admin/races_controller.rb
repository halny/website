# encoding: UTF-8

class Admin::RacesController < AdminController

  before_filter :find_race, only: [:edit, :update, :destroy]

  def index
    @races = Race.all
  end

  def new
    @race = Race.new
  end

  def create
    @race = Race.new(params[:race])

    if @race.save
      redirect_to admin_races_path, notice: "Dodano nowy rajd."
    else
      flash[:error] = "Popraw błędy w formularzu."
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @race.update_attributes(params[:race])
      redirect_to admin_races_path, notice: "Zmiany zapisane."
    else
      flash[:error] = "Popraw błędy w formularzu."
      render action: 'edit'
    end
  end

  def destroy
  end

  private

  def find_race
    @race = Race.find(params[:id])
  end
end
