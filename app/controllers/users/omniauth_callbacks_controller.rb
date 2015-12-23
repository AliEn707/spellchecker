class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def doorkeeper
    oauth_data = request.env["omniauth.auth"]
	@user = User.find_or_create_for_doorkeeper_oauth(oauth_data)
	@user.locale=oauth_data[:info][:locale]
	@user.admin=oauth_data[:info][:admin]
	@user.time_zone=oauth_data[:info][:time_zone]
	@user.save
	cookies[:locale]=@user.locale
	
    sign_in_and_redirect @user
  end
end
