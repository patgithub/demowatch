module EventsHelper
  def event_owner_class
    ((current_user.owns? @event) ? "owner":"admin")
  end
  def event_comment_owner_class( id ) 
    ((current_user.owns? @event.comments.find(id)) ? "owner":"admin")
  end
  def human_date event
    if event.startdate.to_date == Time.now.to_date
      "<div class='today'>" + t(".table.rows.today") + "</div>"
    elsif event.startdate.to_date == Time.now.to_date - 1
      "<div class='yesterday'>" + t(".table.rows.yesterday") + "</div>"
    elsif event.startdate.to_date == Time.now.to_date + 1
      "<div class='tomorrow'>" + t(".table.rows.tomorrow") + "</div>"
    elsif event.startdate <= Time.now && event.startdate > 6.hours.ago
      "<div class='now'>" + t(".table.rows.now") + "</div>"
    elsif event.startdate.year == Time.now.year
      event.startdate && l(event.startdate, :format => :day_month)
    else
      event.startdate && l(event.startdate.to_date)
    end
  end
  
end
