class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  protect_from_forgery except: :sign_in

  respond_to :json

  def angular
    render 'layouts/application'
  end
  #Adding name to devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.for( :sign_up ) { |u| u.permit( :name, :email, :password ) }
  end

end
