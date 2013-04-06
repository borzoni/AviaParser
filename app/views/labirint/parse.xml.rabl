collection @flights, :root => false, :object_root => false
attributes :flight_date, :name, :num_seats
child :arrival_airport => :arrival_airport do
  attributes :title
end
child :departure_airport => :departure_airport do
  attributes :title
end
