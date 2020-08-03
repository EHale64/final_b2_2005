require 'rails_helper'

RSpec.describe "As a visitor, When I visit a flight's show page" do
  before(:each) do
    @airline = Airline.create(name: "Delta")
    @flight = @airline.flights.create(number: 1727, date: "08/03/20", time: "3:30pm MT", departure_city: "Denver", arrival_city: "Reno")
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
end
