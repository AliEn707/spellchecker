Spellchecker::Application.routes.draw do
  resources :domains

	root 'main#index'
	
	post "api/check" => "spellcheck#check"
  
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	devise_scope :user do
		get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
	end
	get "locale", to: "application#set_locale"
end
