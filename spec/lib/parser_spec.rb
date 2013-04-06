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
   
  context "parser implementation" do
    it 'should return empty response if no flights found' do
      stub_http_request(:get, url_regex).to_return(File.new('spec/curls/zero'))
      Parser.parse('06.04.2013', '06.04.2013').should eq []
    end
    
    it 'should return several flights' do
      stub_http_request(:get, url_regex).to_return(File.new('spec/curls/several'))
      puts Parser.parse('06.04.2013', '09.04.2013')
    end

    it 'shoul return empty result if webservice is down' do
      stub_http_request(:get, url_regex).to_return(:status => 500)
      Parser.parse('06.04.2013', '09.04.2013').should eq []
    end

  end
end 
