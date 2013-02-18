class TwitterBot < Sinatra::Base
	register Sinatra::ConfigFile
	config_file '../config.yml'
	DB = Sequel.sqlite 'db/development.sqlite3'

	TweetStream.configure do |config|
		config.consumer_key       = settings.TWITTER_CONSUMER_KEY
		config.consumer_secret    = settings.TWITTER_CONSUMER_SECRET
		config.oauth_token        = settings.TWITTER_ACCESS_KEY
		config.oauth_token_secret = settings.TWITTER_ACCESS_SECRET
		config.auth_method        = :oauth
	end

	get '/hi' do
		u = User.first
		Rack::Utils.escape_html u.name
	end

#	Thread.start do
#		TweetStream::Client.new.sample do |status|
#			puts status.text
#		end
#	end
end
