class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from Exception, :with => :error_render_method

  def error_render_method
    respond_to do |type|
      type.html { render :status => 404 }
      type.all  { render :status => 404 }
    end
    true
  end
end
