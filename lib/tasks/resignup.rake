namespace :demowatch do
  desc "send resignup notifications"
  task :resignup => :environment do
    users = User.all(:conditions => 'activation_code is not null')
    users.each do |user|
      UserMailer.deliver_resignup_notification(user)
      puts user.login
    end
  end
end

