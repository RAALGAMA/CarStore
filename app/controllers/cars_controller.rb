class CarsController < ApplicationController
  # GET /cars/:id
  def show
    @car = Car.find(params[:id])
  end

  # GET /cars/search?keywords=user+search+terms
  def search
    #@car = Car.where('model LIKE ?', "%#{params[:search_term]}%")
    wildcard_search = "%#{params[:search_term]}%"
    model = params[:model]
    @cars = Car.where("model LIKE ?", wildcard_search)
@cars = @cars.where(model: params[:model]) if params[:model].present?
  end
end
