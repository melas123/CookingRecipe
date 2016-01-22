class RatesController < ApplicationController
  before_action :set_rate, only: [:show, :update, :destroy]
  before_filter :authenticate_user!, only: [:create, :update, :destroy]
  # GET /rates
  # GET /rates.json
  def index
    @rates = Rate.find_by( recipe_id: params[:recipe_id] ) 
  end

  # GET /rates/1
  # GET /rates/1.json
  def show
    @rate = Rate.find( params[:id] )
  end

  # GET /rates/new
  def new
    @rate = Rate.new
  end
  
  # POST /rates
  # POST /rates.json
  def create
    @rate = Rate.new( recipe: Recipe.find( params[:recipe_id] ), value: params[:value], user_id: current_user.id )
    respond_to do |format|
      if @rate.save
        format.json { render :show, status: :created, location: @rate }
      else
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rates/1
  # PATCH/PUT /rates/1.json
  def update
    if @rate.user_id == current_user.id 
      @rate.update( value: params[:value] ) 
    end  
  end

  # DELETE /rates/1
  # DELETE /rates/1.json
  def destroy
    @rate.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.find( params[:id] )
    end
    
end
