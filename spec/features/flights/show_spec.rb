require 'rails_helper'

RSpec.describe "As a visitor, When I visit a flight's show page" do
  before(:each) do
    @airline = Airline.create(name: "Delta")
    @flight = @airline.flights.create(number: 1727, date: "08/03/20", time: "3:30pm MT", departure_city: "Denver", arrival_city: "Reno")
    @passenger1 = Passenger.create(name: "Jessica", age: 32)
    @passenger2 = Passenger.create(name: "Ronny", age: 17)
    @passenger3 = Passenger.create(name: "Quentin", age: 19)
    @passenger4 = Passenger.create(name: "Darrel", age: 12)
    PassengerFlight.create(passenger_id: @passenger1.id, flight_id: @flight.id)
    PassengerFlight.create(passenger_id: @passenger2.id, flight_id: @flight.id)
    PassengerFlight.create(passenger_id: @passenger3.id, flight_id: @flight.id)
    PassengerFlight.create(passenger_id: @passenger4.id, flight_id: @flight.id)
  end
    it "I see all of that flight's information" do
      visit "/flights/#{@flight.id}"

      expect(page).to have_content(@flight.number)
      expect(page).to have_content(@flight.date)
      expect(page).to have_content(@flight.time)
      expect(page).to have_content(@flight.departure_city)
      expect(page).to have_content(@flight.arrival_city)
    end

    it "I see the name of the airline this flight belongs" do
      visit "/flights/#{@flight.id}"

      expect(page).to have_content(@airline.name)
    end

    it "I see the names of all of the passengers on this flight" do
      visit "/flights/#{@flight.id}"

        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
        expect(page).to have_content(@passenger3.name)
        expect(page).to have_content(@passenger4.name)
    end

    it "I can see the count of minors and the count of adults on a flight" do
      visit "/flights/#{@flight.id}"

      expect(page).to have_content("Adults: 2")
      expect(page).to have_content("Minors: 2")
    end
end
