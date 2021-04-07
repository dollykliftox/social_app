class CoffeeRoastsController < ApplicationController
  def index
    @coffee_roasts = CoffeeRoast.all  
  end

  # POST /coffee_roasts
  def create
    @coffee_roast = CoffeeRoast.new(coffee_roast_params)

    respond_to do |format|
      if @coffee_roast.save
        message = "The coffee roast '#{@coffee_roast.roast_name}' was just added."
        TwilioTextMessenger.new(message).call
        format.html { redirect_to @coffee_roast, notice: 'Coffee roast was successfully created.' }
        format.json { render :show, status: :created, location: @coffee_roast }
      else
        format.html { render :new }
        format.json { render json: @coffee_roast.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @coffee_roast = CoffeeRoast.find(params[:id])
  end

  private

  def coffee_roast_params
    params.permit(:roast_name , :roast_description)
  end
end
