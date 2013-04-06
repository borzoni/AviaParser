class Airport < ActiveRecord::Base
  has_no_table
  
  has_many :in_flights, :class_name => 'Flight',  foreign_key: "arrival_airport_id"
  has_many :out_flights, :class_name => 'Flight', foreign_key: "departure_airport_id"
  
  column :title, :string
  attr_accessible :title
  validates :title, :presence => true
end
  
