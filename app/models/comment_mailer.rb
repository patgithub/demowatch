class CommentMailer < ActionMailer::Base
  
  def mail(user, comment)
    @recipients  = "info@demowatch.eu"
    @from        = "#{user.email}"
    @subject     = "[www.demowatch.eu] new Comment"
    @sent_on     = Time.now
    @body[:user] = user
    @body[:comment] = comment
  end  

end
