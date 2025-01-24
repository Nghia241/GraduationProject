# class ApplicationController < ActionController::Base
#   before_action :configure_permitted_parameters, if: :devise_controller?
#
#   protected
#
#   def configure_permitted_parameters
#     devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
#     devise_parameter_sanitizer.permit(:account_update, keys: [:name])
#   end
# end
class ApplicationController < ActionController::Base
  before_action :set_devise_mapping
  before_action :set_locale

  private

  def set_devise_mapping
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  def set_locale
    I18n.locale = current_user&.language&.locale || I18n.default_locale
  end
end


