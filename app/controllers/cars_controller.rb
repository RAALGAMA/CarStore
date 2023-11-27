class CarsController < ApplicationController
  # GET /cars/:id
  def show
    @car = Car.find(params[:id])
  end

  def index
    @cars = Car.page(params[:page]).per(10) # Muestra 10 carros por página
  end

  # GET /cars/search?keywords=user+search+terms
  def search
    wildcard_search = "%#{params[:search_term]}%"
    model = params[:model]

    @cars = Car.where("model LIKE ?", wildcard_search)
    @cars = @cars.where(title_status: model) if model.present?
  end
end
