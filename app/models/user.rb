class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	# has_reputation :votes, source: {reputation: :votes, of: :comments}, aggregated_by: :sum

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.name = auth.info.name
			user.twitter_handle = auth.info.nickname
			user.save
		end
	end

	def self.create_with_omniauth(auth)
		create! do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.name = auth["info"]["name"]
			user.twitter_handle = auth["info"]["nickname"]
			user.pic = auth['info']['image']
		end
	end

	def index
		@user = current_user.id
	end
end

# def self.find_or_create_from_auth_hash(auth_hash)
# 	user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
# 	user.update(
# 		name: auth_hash.info.nickname,
# 		profile_image: auth_hash.info.image,
# 		token: auth_hash.credentials.token,
# 		secret: auth_hash.credentials.secret
# 	)
# 	user
# end
