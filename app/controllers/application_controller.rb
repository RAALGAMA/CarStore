class ApplicationController < ActionController::Base
  before_action :initialize_session#, :increment_visit_count
  #before_action :configure_permitted_parameters, if: :devise_controller?
  #helper_method :visit_count
  helper_method :cart

  #private
  def initialize_session
    #session[:visit_count] ||= 0
    session[:shopping_cart] ||= []
  end
  #def increment_visit_count
  #  session[:visit_count] += 1
  #end
  #def visit_count
  #  @visit_count = session[:visit_count]
  #end

  def cart
    # look up a product based upon a series of ids
    Car.find(session[:shopping_cart])
  end
end
