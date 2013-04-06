class LabirintController < ApplicationController
  layout false, except: [:index]

  def parse
    @flights = Parser.parse(params[:date_from], params[:date_to])
  end
end
