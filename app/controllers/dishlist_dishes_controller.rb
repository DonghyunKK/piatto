class DishlistDishesController < ApplicationController
  def create
    @dishlist_dish = DishlistDish.create(strong_params)
    if @dishlist_dish.save!
      redirect_to user_dishlist_path(current_user, @dishlist_dish.dishlist)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @dishlist_dish = DishlistDish.find(params[:id])
    @dishlist_dish.destroy
  end

  private

  def set_dishlist
  end

  def strong_params
    params.require(:dishlist_dish).permit(:dishlist_id, :dish_id)
  end
end