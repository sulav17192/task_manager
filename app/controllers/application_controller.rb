class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You’re not authorized to perform this action."
  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected 

  def configure_permitted_parameters 
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name]) 
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end
end
