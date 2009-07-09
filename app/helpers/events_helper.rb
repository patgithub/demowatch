module EventsHelper
  def event_owner_class
    ((current_user.owns? @event) ? "owner":"admin")
  end
  def test
    (current_user.owns? @event)
  end
end
