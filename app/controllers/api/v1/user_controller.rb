class Api::V1::UserController < ApplicationController

        skip_before_action :login_required


    def create
        token_uri = URI('https://accounts.spotify.com/api/token')

        body = {
            code: params[:code],
            redirect_uri: params[:redirect_uri],
            grant_type: "authorization_code",
            client_id: ENV["CLIENT_ID"],
            client_secret: ENV["CLIENT_SECRET"],
        }

        resp = HTTParty.post(token_uri, body: body)

        resp_params = JSON.parse(resp.body)

        session["access_token"] = resp_params["access_token"]
        session["refresh_token"] = resp_params["refresh_token"]

        render json: resp_params
    end

    def show
        profile_uri = URI('https://api.spotify.com/v1/me')
        access_token = session["access_token"]
        refresh_token = session["refresh_token"]

        user_params = HTTParty.get(profile_uri, headers: {
            "Authorization": "Bearer " + access_token
        })
        
        user_profile = JSON.parse(user_params.body)

        @user = User.find_or_create_by(
            username: user_profile["id"],
            href: user_profile["href"],
            spotify_url: user_profile["external_urls"]["spotify"],
            uri: user_profile["uri"],
        )

        profile_pic = user_profile["images"][0] ? user_profile["images"][0]["url"] : nil

        @user.update(profile_picture: profile_pic)
        @user.update(access_token: access_token, refresh_token: refresh_token)


        render json: {user: {
            username: @user.username,
            spotify_url: @user.spotify_url,
            profile_picture: @user.profile_picture
        }}
    end
end