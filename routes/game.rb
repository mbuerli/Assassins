# encoding: utf-8

class Assassins < Sinatra::Application
    get "/game/new" do        
        @game = Game.new
        erb :game
    end

    post '/game' do
        if session[:access_token]
            # Get base API Connection
            @graph  = Koala::Facebook::API.new(session[:access_token])

            # Get public details of current application
            @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])
            @user    = @graph.get_object("me")

            game = Game.get(params[:id]) || Game.new
            game.name = params[:name]
            game.text = params[:text]
            unless game.id
                game.creationDate = Time.now
                game.createdBy = @user['id']
            end
            if params[:action] == 'save'
              game.save
              redirect "/games"
            elsif params[:action] == 'preview'
              @games = [] << game
              erb :games
            end
        end
    end

    get '/game/:id' do
        @game = Game.get(params[:id])
        erb :game
    end

    delete '/game/:id' do
        game = Game.get(params[:id])
        game.destroy
        redirect "/games"
    end
end