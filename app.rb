# encoding: utf-8
require 'sinatra'
require 'koala'

require_relative 'minify_resources'

unless ENV["FACEBOOK_APP_ID"] && ENV["FACEBOOK_SECRET"]
  abort("missing env vars: please set FACEBOOK_APP_ID and FACEBOOK_SECRET with your app credentials")
end

class Assassins < Sinatra::Application
	enable :sessions

	configure :production do
		set :raise_errors, false
		set :show_exceptions, false
		set :clean_trace, true
		set :css_files, :blob
		set :js_files,  :blob
		MinifyResources.minify_all
	end

	configure :development do
		set :css_files, MinifyResources::CSS_FILES
		set :js_files,  MinifyResources::JS_FILES
		# require_relative 'models/migrate'
	end

	FACEBOOK_SCOPE = 'user_likes,user_photos'

	# before do
	#   # HTTPS redirect
	#   if request.scheme != 'https' #settings.environment == :production && 
	#     redirect "https://#{request.env['HTTP_HOST']}"
	#   end
	# end

	helpers do
		include Rack::Utils
		alias_method :h, :escape_html

		def host
			request.env['HTTP_HOST']
		end

		def scheme
			request.scheme
		end

		def url_no_scheme(path = '')
			"//#{host}#{path}"
		end

		def url(path = '')
			"#{scheme}://#{host}#{path}"
		end

		def authenticator
			@authenticator ||= Koala::Facebook::OAuth.new(ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_SECRET"], url("/auth/facebook/callback"))
		end
	end

	# the facebook session expired! reset ours and restart the process
	error(Koala::Facebook::APIError) do
  		session[:access_token] = nil
  		redirect "/auth/facebook"
	end
end

require_relative 'helpers/init'
require_relative 'models/init'
require_relative 'routes/init'
