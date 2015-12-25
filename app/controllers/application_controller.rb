class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	
	before_action :set_locale
  
	def doorkeeper_oauth_client
		@client ||= OAuth2::Client.new(ENV["APP_ID"], ENV["APP_SECRET"], :site => ENV["APP_URL"])
	end

	def doorkeeper_access_token
		@token ||= OAuth2::AccessToken.new(doorkeeper_oauth_client, current_user.doorkeeper_access_token) if current_user
	end

	def auth_user
		redirect_to user_omniauth_authorize_url(:doorkeeper) unless user_signed_in?
	end
	
	def set_locale
		I18n.locale=cookies[:locale] if !cookies[:locale].nil?
		if !current_user.nil?
			I18n.locale=current_user.locale
			if !params[:locale].nil?
				current_user.locale=params[:locale]
				current_user.save
				redirect_to :back
			end
		else
			if !params[:locale].nil?
				cookies[:locale]=params[:locale]
				redirect_to :back
			end
		end
	end
	
	def new_session_path(scope)
		new_user_session_path
	end
end
