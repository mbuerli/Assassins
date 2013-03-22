# encoding: utf-8

class Assassins < Sinatra::Application
    get '/game/:id/:uid' do
        if session[:access_token]
            @graph = Koala::Facebook::API.new(session[:access_token])
            @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])
            @user = @graph.get_object("me")  
            @game = Game.get(params[:id])
            @profile = Profile.get(params[:uid])
            @player = Player.get(params[:uid], params[:id])
            @targets = Player.all(:game => params[:id]).select{|player| player if !player.assassin && player.id != @player.id}
            erb :player
        else
            redirect "/"
        end
    end

    post '/game/:id/:uid' do
        player = Player.get(params[:uid], params[:id])
        if params[:action] == 'set'
            player.target = Player.get(params[:target], params[:id])
        end
        if params[:action] == 'remove'
            player.target = nil
        end
        player.save
        redirect "/game/"+params[:id]+"/"+params[:uid]
    end
end