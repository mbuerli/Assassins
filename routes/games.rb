# encoding: utf-8

class Assassins < Sinatra::Application
    def join(gid, uid, name, graph)
        if gid
            profile = Profile.get(uid) || Profile.create(:id => uid, :name => name)
            game = Game.get(gid)
            if !profile.games.include? game
                game.profiles << profile
                game.save

                #friends_using_app = graph.fql_query("SELECT uid, is_app_user FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1 = me()) AND is_app_user = 1")
                #uids_using_app = friends_using_app.select{|friend| friend['uid']}
                friends = Player.all #.select{|player| player if !uids_using_app.include? player.id}
                player = Player.new id: profile.id, game: gid
                player.friends += friends
                player.save
            end
        end
    end

    get "/games" do
        if session[:access_token]
            @graph  = Koala::Facebook::API.new(session[:access_token])
            @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])
            @user    = @graph.get_object("me")
            @profile = Profile.get(@user['id']) || Profile.create(:id => @user['id'], :name => @user['name'])
            @games = Game.all.select{|game| game if !@profile.games.include? game}

            erb :games
        else
            redirect "/"
        end
    end

    post "/games" do
        graph = Koala::Facebook::API.new(session[:access_token])
        user = graph.get_object("me")
        # For testing 
        friends_using_app = graph.fql_query("SELECT uid, name FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1 = me()) AND is_app_user = 1")

        if params[:action] == 'join'
            join(params[:id], user['id'], user['name'], graph)
            friends_using_app.each do |friend|
                join(params[:id], friend['uid'], friend['name'], graph)
            end
        end
        redirect "/games"
    end
end
