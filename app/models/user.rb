class User < Sequel::Model(:users)
	def self.find_or_create_by_twitter_user user
		u = User.where( name: user.screen_name ).first
		if u.nil?
			u = User.new name: user.screen_name, score: 1
			u.save
		end
		u
	end
end
