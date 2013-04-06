class Flight < ActiveRecord::Base
  has_no_table
  
  belongs_to  :departure_airport,   :class_name => "Airport"
  belongs_to  :arrival_airport,     :class_name => "Airport"
  
  column :name, :string
  column :flight_date, :date
  column :num_seats, :text 
  attr_accessible :name, :flight_date, :num_seats
  validates :name, :flight_date, :num_seats, :presence => true 
end
