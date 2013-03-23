# encoding: utf-8

class Assassins < Sinatra::Application
    get '/player/:id/:uid' do
        if session[:access_token]
            @graph = Koala::Facebook::API.new(session[:access_token])
            @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])
            @user = @graph.get_object("me")  
            @game = Game.get(params[:id])
            @profile = Profile.get(params[:uid])
            @player = Player.get(params[:uid], params[:id])
            unless @player
                redirect "/"
            end
            @targets = Player.all(:game => params[:id]).select{|player| player if !player.assassin && player.id != @player.id}
            erb :player
        else
            redirect "/"
        end
    end

    post '/player/:id/:uid' do
        player = Player.get(params[:uid], params[:id])
        if params[:action] == 'set'
            player.target = Player.get(params[:target], params[:id])
            player.target.code = "1234"
        elsif params[:action] == 'remove'
            player.target = nil
        elsif params[:action] == 'kill'
            if player.target && params[:killcode] == player.target.code
                player.target.deaths += 1
                player.kills += 1
                player.past_targets += player.target
                player.target = nil
            end
        end
        player.save
        redirect "/player/"+params[:id]+"/"+params[:uid]
    end
end