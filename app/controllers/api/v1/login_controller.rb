class Api::V1::LoginController < ApplicationController
    require "Base64"
    require "net/http"
    def create
        debugger

        query_params = {
            client_id: ENV["CLIENT_ID"],
            response_type: "code",
            redirect_uri: ENV["REDIRECT_URI"],
            scope: "user-read-playback-position user-read-playback-state user-library-read",
            show_dialog: true,
        }
        url = 'https://accounts.spotify.com/authorize/'

        redirect_to "#{url}?#{query_params.to_query}"
    end

    def token
        uri = 'https://accounts.spotify.com/api/token'
        encoded = Base64::encode64("#{ENV['CLIENT_ID']}:#{ENV['CLIENT_SECRET']}").gsub(/\n/,"")

        query_params = {
            code: params[:code],
            redirect_uri: params[:redirect_uri],
            grant_type: "authorization_code",
            headers: {
                Authorization: encoded,
            }
        }

        # res = Net::HTTP.post_form(uri, 'q' => ["#{query_params}"])
    end

end
