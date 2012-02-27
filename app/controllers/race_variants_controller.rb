class RaceVariantsController < ApplicationController
  # GET /race_variants
  # GET /race_variants.json
  def index
    @race_variants = RaceVariant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @race_variants }
    end
  end

  # GET /race_variants/1
  # GET /race_variants/1.json
  def show
    @race_variant = RaceVariant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @race_variant }
    end
  end

  # GET /race_variants/new
  # GET /race_variants/new.json
  def new
    @race_variant = RaceVariant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @race_variant }
    end
  end

  # GET /race_variants/1/edit
  def edit
    @race_variant = RaceVariant.find(params[:id])
  end

  # POST /race_variants
  # POST /race_variants.json
  def create
    @race_variant = RaceVariant.new(params[:race_variant])

    respond_to do |format|
      if @race_variant.save
        format.html { redirect_to @race_variant, notice: 'Race variant was successfully created.' }
        format.json { render json: @race_variant, status: :created, location: @race_variant }
      else
        format.html { render action: "new" }
        format.json { render json: @race_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /race_variants/1
  # PUT /race_variants/1.json
  def update
    @race_variant = RaceVariant.find(params[:id])

    respond_to do |format|
      if @race_variant.update_attributes(params[:race_variant])
        format.html { redirect_to @race_variant, notice: 'Race variant was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @race_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /race_variants/1
  # DELETE /race_variants/1.json
  def destroy
    @race_variant = RaceVariant.find(params[:id])
    @race_variant.destroy

    respond_to do |format|
      format.html { redirect_to race_variants_url }
      format.json { head :ok }
    end
  end
end
