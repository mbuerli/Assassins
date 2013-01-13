# encoding: utf-8
class Assassins < Sinatra::Application
	get "/" do
        # Get base API Connection
        @graph  = Koala::Facebook::API.new(session[:access_token])

        # Get public details of current application
        begin
            @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])
        rescue Exception => e
            session[:access_token] = nil
            @graph  = Koala::Facebook::API.new(session[:access_token])
            @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])
        end

        if session[:access_token]
            @user    = @graph.get_object("me")
        end
        erb :main
    end

    # used by Canvas apps - redirect the POST to be a regular GET
    post "/" do
        redirect "/"
    end

    # used to close the browser window opened to post to wall/send to friends
    get "/close" do
        "<body onload='window.close();'/>"
    end

    get "/sign_out" do
        session[:access_token] = nil
        redirect '/'
    end

    get "/auth/facebook" do
        session[:access_token] = nil
        redirect authenticator.url_for_oauth_code(:permissions => FACEBOOK_SCOPE)
    end

    get '/auth/facebook/callback' do
        session[:access_token] = authenticator.get_access_token(params[:code])
        redirect '/'
    end
end
