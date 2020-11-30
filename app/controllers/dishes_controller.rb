class DishesController < ApplicationController
  before_action :set_user, only: [:index, :create]

  def index
    @dishes = Dish.all
  end

  def new
    @dish = Dish.new
  end

  def show
    index
    @dish = Dish.find(params[:id])
    @restaurant = @dish.restaurant
    @review = Review.new
    @marker = {
      lat: @restaurant.latitude,
      lng: @restaurant.longitude,
      # infoWindow: render_to_string(partial: "info_window", locals: { flat: flat })
    }
  end

  def create
    @dish = Dish.new(params[:dish])
    @restaurant = Restaurant.new(params[:restaurant_id])
    @dish.restaurant = @restaurant
    if @dish.save
      flash[:success] = "Dish successfully created"
      redirect_to @dish
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @dish = Dish.find(params[:id])
    if @dish.update_attributes(params[:dish])
      flash[:success] = "Dish was successfully updated"
      redirect_to @dish
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    @dish = Dish.find(params[:id])
    @dish.destroy
    redirect_to dashboard_path
  end

  private

  def dish_params
    params.require(:dish).permit(:name)
  end
  
end
