module OmniAuth
  module Strategies
    class Doorkeeper < OmniAuth::Strategies::OAuth2
      option :name, :doorkeeper

      option :client_options, {
        :site => "http://localhost:4000",
        :authorize_path => "/oauth/authorize"
      }
	  option :authorize_params, { locale: "en"}

      uid do
        raw_info["id"]
      end

      info do
        {
          :locale => raw_info["locale"],
          :time_zone => raw_info["time_zone"],
          :email => raw_info["email"],
          :admin => raw_info["admin"]
        }
      end

		def raw_info
			@raw_info ||= access_token.get('/api/v1/me.json').parsed
		end
		
		def setup_phase
				request.env['omniauth.strategy'].options[:authorize_params][:locale] = I18n.locale#request.params["locale"]
		end
    end
  end
end
