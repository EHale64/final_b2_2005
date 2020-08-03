require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many :passenger_flights}
    it {should have_many(:passengers).through(:passenger_flights)}
  end

    describe "instance methods" do
      it "counts minors" do
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

        expect(@flight.passengers.minors).to eq(2)
      end
      it "counts adults" do
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

        expect(@flight.passengers.minors).to eq(2)
      end
    end
end
