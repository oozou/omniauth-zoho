require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Zoho < OmniAuth::Strategies::OAuth2
      option :name, "zoho"

      option :client_options, {
        :site => 'https://accounts.zoho.com',
        :authorize_url => 'https://accounts.zoho.com/oauth/v2/auth',
        :token_url => 'https://accounts.zoho.com/oauth/v2/token'
      }

      option provider_ignores_state: true
      option :authorize_options, [:access_type, :prompt, :scope]

      def authorize_params
        super.tap do |params|
          options[:authorize_options].each do |k|
            next if [nil, ''].include?(request.params[k.to_s])

            params[k] = request.params[k.to_s]
          end

          params[:access_type] = 'offline' if params[:access_type].nil?
        end
      end

      uid { raw_info['ZUID'].to_s }

      info do
        {
          email: raw_info['Email'],
          first_name: raw_info['First_Name'],
          last_name: raw_info['Last_Name'],
          display_name: raw_info['Display_Name']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      credentials do
        hash = { "token" => access_token.token }
        if access_token.refresh_token
          hash['refresh_token'] = access_token.refresh_token
        end

        if access_token.params['expires_in_sec']
          hash['expires_at'] = Time.now.to_i + access_token.params['expires_in_sec'].to_i
        end

        hash['expires'] = access_token.expires?
        hash
      end

      def raw_info
        @raw_info ||= access_token.get('/oauth/user/info', parse: :json).parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
