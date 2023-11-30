class UsersController < ApplicationController
  protected

  def after_sign_up_path_for(resource)
    # Customize the path where the user should be redirected after sign-up
    root_path
  end
end
