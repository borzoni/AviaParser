require 'spec_helper'
require 'parser'

url_regex = /online.nectravel.ru\/freight_monitor.*/  # for mocking

describe Parser do
   context "auxiliary functions" do
      it 'should adjust dates earlier than today' do
        from = 100.days.ago.to_s
        to = 50.day.ago.to_s
       
        start = Date.today
        dif = 0
        
        Parser.send(:process_interval, from, to).should eql [start, dif]
        
      end
      
    it 'should raise error when dates are insensible' do
      from = Date.today + 10.days
      to = Date.today + 5.day
      
      expect { Parser.send(:process_interval, from.to_s, to.to_s) }.to raise_error(ArgumentError)
    end
    
   end
end 
