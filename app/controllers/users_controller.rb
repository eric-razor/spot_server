class UsersController < ApplicationController
    def create
        byebug
        query_params = {
            client_id: ENV[:CLIENT_ID],
            response_type: "code",
            redirect_uri: ENV["REDIRECT_URI"],
            scope: 'user-read-playback-position user-read-playback-state user-library-read',
            show_dialog: true
        }
        url = 'https://accounts.spotify.com/authorize'

    end
end
