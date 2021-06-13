class Api::V1::UserController < ApplicationController
    
    def create
        uri = URI('https://accounts.spotify.com/api/token')

        body = {
            code: params[:code],
            redirect_uri: params[:redirect_uri],
            grant_type: "authorization_code",
            client_id: ENV["CLIENT_ID"],
            client_secret: ENV["CLIENT_SECRET"],
        }

        resp = HTTParty.post(uri, body: body)

        render json: resp
    end

end