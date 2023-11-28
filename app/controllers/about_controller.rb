class AboutController < ApplicationController
  def about
    @abouts = About.order(params[:content])
  end
end
