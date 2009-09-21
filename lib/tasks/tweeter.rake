namespace :demowatch do
  desc "send demo notifications via twitter"
  task :tweeter => :environment do
    # get all events that happen in future
    events = Event.all(:conditions => "startdate >='" + Time.now.to_s(:db) + "'")
    events.each do |event|
      # check if tweet level is not initialized yet
      # that is when the event is new or updated
      if event.tweetlevel.nil?
        # tweet message
        Tweet.update_status event.tweet
        # initialize next trigger
        event.tweetlevel = event.calc_tweetlevel
        event.save
      elsif event.tweet_level > 0 && event.tweetlevel == event.calc_tweetlevel
        # tweet message
        Tweet.update_status event.tweet
        # next tweet level
        event.tweetlevel -= 1
        event.save
      end
    end
  end
end

