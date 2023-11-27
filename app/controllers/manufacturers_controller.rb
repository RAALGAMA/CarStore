class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.order(:name)
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
    @social_media = @manufacturer.social_media
    @cars = @manufacturer.cars.page(params[:page]).per(10) # Muestra 10 carros por página en la vista show
  end
end
