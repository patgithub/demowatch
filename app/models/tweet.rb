class Tweet < ActiveResource::Base
  self.site = TWITTER_CONFIG['site']
  self.user = TWITTER_CONFIG['user']
  self.password = TWITTER_CONFIG['password']

  def self.update_status(content)
    if !site.nil?
      connection.post("/statuses/update.xml?status="+CGI.escape(content)) 
    end
  end
end
