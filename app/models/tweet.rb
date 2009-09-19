class Tweet < ActiveResource::Base
  # load twitter configuration
  TWITTER_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/twitter.yml")

  self.site = TWITTER_CONFIG['site']
  self.user = TWITTER_CONFIG['user']
  self.password = TWITTER_CONFIG['password']

  def self.update_status(content)
    if !site.nil?
      connection.post("/statuses/update.xml?status="+CGI.escape(content)) 
    end
  end
end
