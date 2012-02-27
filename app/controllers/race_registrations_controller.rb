class RaceRegistrationsController < ApplicationController
  # GET /race_registrations
  # GET /race_registrations.json
  def index
    @race_registrations = RaceRegistration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @race_registrations }
    end
  end

  # GET /race_registrations/1
  # GET /race_registrations/1.json
  def show
    @race_registration = RaceRegistration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @race_registration }
    end
  end

  # GET /race_registrations/new
  # GET /race_registrations/new.json
  def new
    @race_registration = RaceRegistration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @race_registration }
    end
  end

  # GET /race_registrations/1/edit
  def edit
    @race_registration = RaceRegistration.find(params[:id])
  end

  # POST /race_registrations
  # POST /race_registrations.json
  def create
    @race_registration = RaceRegistration.new(params[:race_registration])

    respond_to do |format|
      if @race_registration.save
        format.html { redirect_to @race_registration, notice: 'Race registration was successfully created.' }
        format.json { render json: @race_registration, status: :created, location: @race_registration }
      else
        format.html { render action: "new" }
        format.json { render json: @race_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /race_registrations/1
  # PUT /race_registrations/1.json
  def update
    @race_registration = RaceRegistration.find(params[:id])

    respond_to do |format|
      if @race_registration.update_attributes(params[:race_registration])
        format.html { redirect_to @race_registration, notice: 'Race registration was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @race_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /race_registrations/1
  # DELETE /race_registrations/1.json
  def destroy
    @race_registration = RaceRegistration.find(params[:id])
    @race_registration.destroy

    respond_to do |format|
      format.html { redirect_to race_registrations_url }
      format.json { head :ok }
    end
  end
end
