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

	get '/hi' do
		Rack::Utils.escape_html "hello world<script>alert('lol')</script>"
	end

	Thread.start do
		TweetStream::Client.new.sample do |status|
			puts status.text
			puts status.inspect
			TweetStream.stop
		end
	end
end
