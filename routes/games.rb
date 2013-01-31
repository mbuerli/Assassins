# encoding: utf-8

class Assassins < Sinatra::Application
    get "/games" do
        if session[:access_token]
            # Get base API Connection
            @graph  = Koala::Facebook::API.new(session[:access_token])

            # Get public details of current application
            @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])
            @user    = @graph.get_object("me")
            @profile = Profile.get(@user['id'])

            begin
                @games = Game.all
            rescue Exception => e
                # database troubles
            end

            erb :games
        else
            redirect "/"
        end
    end

    # used by Canvas apps - redirect the POST to be a regular GET
    post "/games" do
        if params[:action] == 'join'
            if params[:id]
                profile = Profile.get(params[:uid]) || Profile.new(:id => params[:uid], :name => params[:name])
                game = Game.get(params[:id])
                profile.games << game
                profile.save
            end
        end
        redirect "/games"
    end
end
