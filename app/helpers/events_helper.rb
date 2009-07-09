module EventsHelper
  def event_owner_class
    ((current_user.owns? @event) ? "owner":"admin")
  end
  def event_comment_owner_class( id ) 
    ((current_user.owns? @event.comments.find(id)) ? "owner":"admin")
  end
end
