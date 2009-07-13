class FrontController < ApplicationController
 
 
  def index
  end
  
  def all
    @tags = Tag.counts
    @list_type = "all"
    render :action => 'index'
  end
  
  def events
    @tags = Event.tag_counts
    @list_type = "events"
    render :action => 'index'
  end

  def other
    @tags = Tag.counts :conditions => "taggable_type IN ('Organisation', 'User')"
    @list_type = "other"
    render :action => 'index'
  end

  def current
    @tags = Tag.counts :conditions => "taggable_type='event' AND EXISTS (SELECT * FROM events e WHERE startdate > '#{1.day.ago.to_formatted_s(:db)}' AND taggable_id=e.id)"
    @list_type = "current"
    render :action => 'index'
  end
 
  def powerless
    @tags = Tag.counts :conditions => "taggable_type='event' AND NOT EXISTS (SELECT * FROM events e WHERE startdate > '#{1.day.ago.to_formatted_s(:db)}' AND taggable_id=e.id)"
    @list_type = "powerless"
    render :action => 'index'
  end
  
  def imprint
  end

  def about
  end
  
  def show
  ## hack, um alte links ala /tag/:id nach /tag/:name umzuleiten
    if params[:name].is_numeric?
      tag = Tag.find_by_id(params[:name])
      redirect_to '/tag/' + tag.name, :status=>:moved_permanently
    end
      
      
    @tag = Tag.find_by_name(params[:name])
    @with_distance = !current_user.nil? && !current_user.zip.nil?
    if( @with_distance)	  
      # mit entfernung
  	  origin = GeoKit::LatLng.new(current_user.zip.latitude, current_user.zip.longitude);
      @events = Event.find_tagged_with(@tag, :origin => origin, :order => 'startdate DESC')
    else 
      @events = Event.find_tagged_with(@tag, :order => 'startdate DESC')
    end  
    @organisations = Organisation.find_tagged_with(@tag)
    @related_tags = (@events.map{|e| e.tags} + @organisations.map{|o| o.tags}).flatten.uniq   
  end
end
