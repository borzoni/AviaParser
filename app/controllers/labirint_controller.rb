class LabirintController < ApplicationController
  layout false, except: [:index]

  def parse
    begin
      @flights = Parser.parse(params[:date_from], params[:date_to])
    rescue
      render:status => 500
    end
  end
end
