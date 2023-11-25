class CarsController < ApplicationController
  # GET /cars/:id
  def show
    @car = Car.find(params[:id])
  end

  # GET /cars/search?keywords=user+search+terms
  def search
    @car = Car.where('model LIKE ?', "%#{params[:search_term]}%")
  end
end
