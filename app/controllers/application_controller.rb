# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time


  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '3a5df53b34706fb7a4b7c45303d16813'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  rescue_from Authorization::PermissionDenied, :with => :permission_denied
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  
  
  before_filter :redirect_to_www_demowatch_de
  before_filter :set_locale
  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{I18n.locale}'"
  end
  def redirect_to_www_demowatch_de
    if !request.host.include?('localhost') 
      if extract_locale_from_accept_language_header == 'de' && request.host.match( /^www\.demowatch\.de/i).nil?
        redirect_to "http://www.demowatch.de" + request.path, :status=>:moved_permanently
      elsif extract_locale_from_accept_language_header == 'en' && request.host.match( /^www\.demowatch\.eu/i).nil?
        redirect_to "http://www.demowatch.eu" + request.path, :status=>:moved_permanently
      end
    end
  end  
  
protected
  def permission_denied(exception)
    flash[:notice] = t("layouts.application.flash.no_permission")
    redirect_to :front
  end
  
  def not_found(exception)
    flash[:notice] = t("layouts.application.flash.not_found")
    redirect_to :front
  end
private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end  # zur hauptdomain umleiten

end
