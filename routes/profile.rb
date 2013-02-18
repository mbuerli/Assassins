# encoding: utf-8
class Assassins < Sinatra::Application
    get "/profile" do
        if session[:access_token]
            # Get base API Connection
            @graph  = Koala::Facebook::API.new(session[:access_token])

            # Get public details of current application
            @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])
            @user = @graph.get_object("me")
            @profile = Profile.get(@user['id']) || Profile.create(:id => @user['id'], :name => @user['name'])

            # for other data you can always run fql
            @friends_using_app = @graph.fql_query("SELECT uid, name, is_app_user, pic_square FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1 = me()) AND is_app_user = 1").first(12)
            erb :profile
        else
            redirect "/"
        end
    end

    get "/profile/edit" do
        if session[:access_token]
            # Get base API Connection
            @graph  = Koala::Facebook::API.new(session[:access_token])
            @editing = 1
            # Get public details of current application
            @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])
            @user = @graph.get_object("me")
            @profile = Profile.get(@user['id']) || Profile.create(:id => @user['id'], :name => @user['name'])

            erb :profile
        else
            redirect "/"
        end
    end

    # used by Canvas apps - redirect the POST to be a regular GET
    post "/profile" do
        if params[:action] == 'edit'
            @graph  = Koala::Facebook::API.new(session[:access_token])
            @user = @graph.get_object("me")

            profile = Profile.get(@user['id'])
            profile.nickname = params[:nickname]
            if profile.save
            else
                profile.errors.each do |e|
                    puts e
                end
            end
        end
        redirect "/profile"
    end
end
