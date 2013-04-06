class Parser
  class << self
    def parse(from_date, to_date)
      start, days_count = process_interval(from_date, to_date)  
      url = make_full_url(start, days_count)
      response = get_response(url)
    end

    private
    
    # conversion subroutine
    # also simple validation
    def process_interval(date_from, date_to)
      from = Date.parse(date_from)
      to =  Date.parse(date_to)
      # adjust dates
      from = Date.today if from < Date.today
      to = Date.today if to < Date.today
      if from > to
        raise ArgumentError.new('Date of Arrival is less than Departure Date')
      end
      dif = (to - from).to_i
      [from, dif]
    end
    
    def get_response(url)
      raw_data = RestClient.get(url)
      raw_data.force_encoding('WINDOWS-1251').encode('UTF-8')   # lovely encoding issues...   
      result = raw_data[/(<table.*\/table>)/im]                 # extract actual html content(it's inside table tags)
      Nokogiri::HTML.parse(result)                                                            
    end
    
    def make_full_url(start_endpoint, days_count)
      main_part = "http://online.nectravel.ru/freight_monitor/"
      query_string = {
          :samo_action => 'FREIGHTS',                       # requested action. dunno what 'samo' stands for.
          :TOWNFROMINC => '2',                              # town?? towns rarely have airports). Anyway it's the settlement of departure
          :STATEINC => '3',                                 # the desired country 
          :TOWNTOINC => '5',                                # the desired settlement
          :CHECKIN => start_endpoint.strftime('%Y%m%d'),    # from endpoint
          :NIGHTS_FROM => days_count,                       # let it be the duration
      }
      main_part + "?#{query_string.to_param}"
    end
  end
end
