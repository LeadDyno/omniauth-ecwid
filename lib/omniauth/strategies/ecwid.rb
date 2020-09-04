require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Ecwid < OmniAuth::Strategies::OAuth2

      option :name, "ecwid"
      option :client_options, {
        :site => 'https://my.ecwid.com',
        :authorize_url => '/api/oauth/authorize',
        :token_url => '/api/oauth/token'
      }

      # scope: "read_orders update_catalog", etc
      # grant_type: "code"
      option :authorize_options, [:scope, :grant_type]

      uid {
        access_token.params.fetch("store_id")
      }

      # ecwid doesnt like it when the query params are also passed
      def callback_url
        full_host + script_name + callback_path
      end

    end
  end
end
