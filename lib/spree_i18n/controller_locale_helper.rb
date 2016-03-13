module SpreeI18n
  # The fact this logic is in a single module also helps to apply a custom
  # locale on the spree/api context since api base controller inherits from
  # MetalController instead of Spree::BaseController
  module ControllerLocaleHelper
    extend ActiveSupport::Concern
    included do
      before_filter :set_user_language
      before_filter :globalize_fallbacks

      private
        # Overrides the Spree::Core::ControllerHelpers::Common logic so that only
        # supported locales defined by SpreeI18n::Config.supported_locales can
        # actually be set
        def set_user_language
          if spree_current_user && Config.supported_locales.include?(spree_current_user.language.to_sym)
            if params[:language] && Config.supported_locales.include?(params[:language].to_sym)
              spree_current_user.update_attribute(:language, params[:language])
            end
            I18n.locale = spree_current_user.language.to_sym
          else
            I18n.locale = if params[:locale] && Config.supported_locales.include?(params[:locale].to_sym)
              params[:locale]
            elsif respond_to?(:config_locale, true) && !config_locale.blank?
              config_locale
            else
              Rails.application.config.i18n.default_locale || I18n.default_locale
            end   
          end
        end

        def globalize_fallbacks
          Fallbacks.config!
        end

    end
  end
end
