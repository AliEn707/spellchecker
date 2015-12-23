class MainController < ApplicationController
	before_action :auth_user, except: [ :index ]
	def index
	end
end
