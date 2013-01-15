# encoding: utf-8

# create some temp games
Game.create name: 'First game of the quarter'
Game.create name: 'Test Game'
Game.create name: 'Deathmatch'

class Assassins < Sinatra::Application
    get "/target" do
        if session[:access_token]
            # Get base API Connection
            @graph  = Koala::Facebook::API.new(session[:access_token])

            # Get public details of current application
            @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])
            @user    = @graph.get_object("me")

            begin
                @games = Game.all
            rescue Exception => e
                
                # database troubles
            end

            erb :target
        else
            redirect "/"
        end
    end

    # used by Canvas apps - redirect the POST to be a regular GET
    post "/target" do
        redirect "/target"
    end
end
