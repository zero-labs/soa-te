# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  protect_from_forgery :except => 'auto_complete_for_tag_name'
    
  before_filter :body_id, :map_properties
  around_filter :set_language
  
  def index
  end
  
  # Changes the currently selected campus
  def toggle_campus
    if (params[:campus] == 'tagus')
      session[:campus] = :tagus
      session[:center] = APP_CONFIG[:tagus_center]
      session[:zoom] = APP_CONFIG[:tagus_zoom]
    else
      session[:campus] = :alameda
      session[:center] = APP_CONFIG[:alameda_center]
      session[:zoom] = APP_CONFIG[:alameda_zoom]
    end
    render(:update) do |page|
      page.replace_html 'campus_placeholder', :partial => '/sounds/campus'
    end
  end
  
  def derivatives
    @body_id = :derivatives
  end
  
  private
  
  def body_id
    @body_id = :home # default value
  end
  
  def map_properties
    session[:campus] = :alameda if session[:campus].blank? # default value
    session[:center] = APP_CONFIG[:alameda_center] if session[:center].blank?
    session[:zoom] = APP_CONFIG[:alameda_zoom] if session[:zoon].blank?
  end
  
  def set_language
    session[:language] = :pt if session[:language].blank? # default value
    Gibberish.use_language(session[:language]) { yield }
  end
end
