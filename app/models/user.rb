class User < ApplicationRecord
    has_many :songs

    validates :username, uniqueness: true, presence: true

    def access_token_expired?
        (Time.now - self.updated_at) > 3300
    end

    def refresh_access_token
        if access_token_expired?
            
            body = {
                grant_type: "refresh_token",
                refresh_token: self.refresh_token,
                client_id: ENV["CLIENT_ID"],
                client_secret: ENV["CLIENT_SECRET"]
            }

            refresh_response = HTTParty.post('https://accounts.spotify.com/api/token', body)
            refresh_params = JSON.parse(refresh_response)
            self.update(access_token: refresh_params["access_token"])
        else
            puts "Token not expired"
        end
    end
end

