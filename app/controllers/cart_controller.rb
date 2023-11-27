class CartController < ApplicationController
  def create
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i
    session[:shopping_cart] << id unless session[:shopping_cart].include?(id)
    car = Car.find(id)
    flash[:notice] = "+ #{car.brand} #{car.model} added to cart..."
    redirect_to root_path
  end
  def destroy
    logger.debug("removing #{params[:id]} from the Cart.")
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    redirect_to root_path
  end
end
