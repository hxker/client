require 'omniauth-oauth2'
module OmniAuth
  module Strategies
    class Login < OmniAuth::Strategies::OAuth2

      CUSTOM_PROVIDER_URL = 'http://localhost:3000'

      option :client_options, {
                                :site => CUSTOM_PROVIDER_URL,
                                :authorize_url => "#{CUSTOM_PROVIDER_URL}/auth/login/authorize",
                                :access_token_url => "#{CUSTOM_PROVIDER_URL}/auth/login/access_token"
                            }

      uid do
        raw_info['id']
      end

      info do
        {
            :email => raw_info['info']['email']
        }
      end

      extra do
        {
            :first_name => raw_info['extra']['first_name'],
            :last_name => raw_info['extra']['last_name']
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/auth/login/user.json?oauth_token=#{access_token.token}").parsed
      end
    end


    class Register < OmniAuth::Strategies::OAuth2

      #   CUSTOM_PROVIDER_URL = 'http://localhost:3000'
      #
      #   option :client_options, {
      #                             :site => CUSTOM_PROVIDER_URL,
      #                             :authorize_url => "#{CUSTOM_PROVIDER_URL}/auth/register/authorize",
      #                             :access_token_url => "#{CUSTOM_PROVIDER_URL}/auth/register/access_token"
      #                         }
      #
      #   uid do
      #     raw_info['id']
      #   end
      #
      #   info do
      #     {
      #         :email => raw_info['info']['email']
      #     }
      #   end
      #
      #   extra do
      #     {
      #         :first_name => raw_info['extra']['first_name'],
      #         :last_name => raw_info['extra']['last_name']
      #     }
      #   end
      #
      #   def raw_info
      #     @raw_info ||= access_token.get("/auth/register/user.json?oauth_token=#{access_token.token}").parsed
      #   end
    end

  end
end
