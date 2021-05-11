class Api::V1::UserController < ApplicationController
    require "Base64"
    require "net/http"
    def create
        uri = URI.parse('https://accounts.spotify.com/api/token')
        encoded = Base64::strict_encode64("#{ENV["CLIENT_ID"]}:#{ENV["CLIENT_SECRET"]}")

        form_params = {
            code: params[:code],
            redirect_uri: params[:redirect_uri],
            grant_type: "authorization_code",
        }

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == "https")
        req = Net::HTTP::Post.new(uri.request_uri)
        req.set_form_data(form_params)
        req["Authorization"] = 'Authorization: Basic ' +  Base64::strict_encode64(ENV["CLIENT_ID"] + ":" + ENV["CLIENT_SECRET"])

        res = http.request(req)
        res.inspect

        debugger

        case res
        when Net::HTTPSuccess, Net::HTTPRedirection

        else
        res.value
        end


    end
end
