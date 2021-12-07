module DeviseWhiteList
    extend ActiveSupport::Consern

    included do
        before_action:configure_permitted_paramaters, if: :devise_controller?
    end

    def configure_permitted_paramaters
        attributes = [:name, :type]
        devise_parameter_sanitizer.permit(:sign_up,keys: attributes)
        devise_parameter_sanitizer.permit(:account_update,keys: attributes)
    end


end
