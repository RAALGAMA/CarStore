class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.order(:name)
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
    @social_media = @manufacturer.social_media
  end
end
