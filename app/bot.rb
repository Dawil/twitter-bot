class TwitterBot < Sinatra::Base
	register Sinatra::ConfigFile
	config_file '../config.yml'
	DB = Sequel.sqlite 'db/development.sqlite3'

	Twitter.configure do |config|
		config.consumer_key       = settings.TWITTER_CONSUMER_KEY
		config.consumer_secret    = settings.TWITTER_CONSUMER_SECRET
		config.oauth_token        = settings.TWITTER_ACCESS_KEY
		config.oauth_token_secret = settings.TWITTER_ACCESS_SECRET
	end

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
		Twitter.update "tweet"
		"done"
	end

	Thread.start do
		TweetStream::Client.new.userstream do |status|
			u = User.find_or_create_by_twitter_user status.user
			entities = status.attrs[:entities]
			url = status.attrs[:entities][:urls].first
			puts url
			u.score += 5
			u.save
			msg = "@#{ u.name } nice link, #{ url[:expanded_url] }! +5pts"
			puts msg
			Twitter.update msg
			Twitter.update "tweet"
		end
	end
end
