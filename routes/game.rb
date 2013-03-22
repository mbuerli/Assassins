# encoding: utf-8

class Assassins < Sinatra::Application
    get "/game/new" do  
        if session[:access_token]
            @graph = Koala::Facebook::API.new(session[:access_token])
            @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])
            @user = @graph.get_object("me")      
            @game = Game.new
            erb :game
        else
            redirect "/"
        end
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
                if game.save
                else
                    game.errors.each do |e|
                        puts e
                    end
                end
                redirect "/games"
            elsif params[:action] == 'preview'
                @games = [] << game
                erb :games
            end
        end
    end

    get '/game/:id' do
        @game = Game.get(params[:id])
        if session[:access_token] && @game
            @graph = Koala::Facebook::API.new(session[:access_token])
            @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])
            @user = @graph.get_object("me")  
            erb :game
        else
            redirect "/"
        end
    end

    delete '/game/:id' do
        game = Game.get(params[:id])
        game.destroy
        redirect "/games"
    end
end