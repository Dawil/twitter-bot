class TwitterBot < Sinatra::Base
	register Sinatra::ConfigFile
	config_file 'config.yml'

	TweetStream.configure do |config|
		config.consumer_key       = settings.TWITTER_CONSUMER_KEY
		config.consumer_secret    = settings.TWITTER_CONSUMER_SECRET
		config.oauth_token        = settings.TWITTER_ACCESS_KEY
		config.oauth_token_secret = settings.TWITTER_ACCESS_SECRET
		config.auth_method        = :oauth
	end

	TweetStream::Client.new.userstream do |status|
		puts status.text
	end

	get '/hi' do
		settings.TWITTER_CONSUMER_KEY
	end
end
