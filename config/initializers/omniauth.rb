OmniAuth.config.logger = Rails.logger

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :twitter, ENV['api_key'], ENV["api_secret"]
# end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['api_key'], ENV["api_secret"],
    {
      :secure_image_url => 'true',
      :image_size => 'normal',
      :authorize_params => {
        :force_login => 'true',
        :lang => 'pt'
      }
    }
end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :developer unless Rails.env.production?
#   provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
# end
