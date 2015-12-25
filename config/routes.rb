Spellchecker::Application.routes.draw do
  get "documentation/install"
  get "documentation/languages"
  get "documentation/api"
  resources :domains

	root 'main#index'
	
	post "api/check" => "spellcheck#check"
	get "api/check" => "spellcheck#check"
  
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	devise_scope :user do
		get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
		get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
	end
	get "locale", to: "application#set_locale"
end
