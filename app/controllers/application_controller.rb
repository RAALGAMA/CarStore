class ApplicationController < ActionController::Base
  def initialize_session
    session[:visit_count] ||= 0
  end
  def increment_visit_count
    session[:visit_count] += 1
  end
  def visit_count
    @visit_count = session[:visit_count]
  end

end
