class Tweet
  # load twitter configuration
  TWITTER_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/twitter.yml")

  def self.config(key)
    TWITTER_CONFIG[key.to_s]
  end

  def self.update_status(content)
    unless TWITTER_CONFIG.blank?
      consumer = OAuth::Consumer.new(config(:consumer_key), config(:consumer_secret), :site => 'https://api.twitter.com', :scheme => :header)
      access_token = OAuth::AccessToken.from_hash(consumer, :oauth_token => config(:oauth_token), :oauth_token_secret => config(:oauth_token_secret))
      access_token.request(:post, 'http://api.twitter.com/statuses/update.xml?status=' + CGI.escape(content))
    end
  end
end
