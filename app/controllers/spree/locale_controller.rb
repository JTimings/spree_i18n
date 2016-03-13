module Spree
  class LocaleController < Spree::StoreController
    def set
    	url_hash = Spree::Core::Engine.routes.recognize_path URI(request.referer).path
			url_hash[:locale] = params[:switch_to_locale]
			spree_current_user.update_attribute(:language, params[:switch_to_locale]) if spree_current_user
			redirect_to url_hash
    end
  end
end