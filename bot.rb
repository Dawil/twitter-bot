class TwitterBot < Sinatra::Base
	register Sinatra::ConfigFile
	config_file 'config.yml'

	get '/hi' do
		settings.TWITTER_CONSUMER_KEY
	end
end
