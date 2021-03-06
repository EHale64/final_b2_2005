require 'rails_helper'

RSpec.describe "As a visitor, When I visit a passengers show page" do
  before(:each) do
    @airline1 = Airline.create(name: "Delta")
    @airline2 = Airline.create(name: "Frontier")
    @flight1 = @airline1.flights.create(number: 1727, date: "08/03/20", time: "3:30pm MT", departure_city: "Denver", arrival_city: "Reno")
    @flight2 = @airline2.flights.create(number: 7172, date: "08/03/20", time: "4:55pm MT", departure_city: "Reno", arrival_city: "LA")
    @flight3 = @airline2.flights.create(number: 7777, date: "08/07/20", time: "7:00am MT", departure_city: "LA", arrival_city: "Reno")
    @passenger1 = Passenger.create(name: "Jessica", age: 32)
    @passenger2 = Passenger.create(name: "Ronny", age: 17)
    @passenger3 = Passenger.create(name: "Quentin", age: 19)
    @passenger4 = Passenger.create(name: "Darrel", age: 12)
    PassengerFlight.create(passenger_id: @passenger1.id, flight_id: @flight1.id)
    PassengerFlight.create(passenger_id: @passenger2.id, flight_id: @flight1.id)
    PassengerFlight.create(passenger_id: @passenger3.id, flight_id: @flight1.id)
    PassengerFlight.create(passenger_id: @passenger4.id, flight_id: @flight1.id)
    PassengerFlight.create(passenger_id: @passenger1.id, flight_id: @flight2.id)
    PassengerFlight.create(passenger_id: @passenger2.id, flight_id: @flight2.id)
    PassengerFlight.create(passenger_id: @passenger3.id, flight_id: @flight2.id)
    PassengerFlight.create(passenger_id: @passenger4.id, flight_id: @flight2.id)
  end

  it "I see that passengers name" do
    visit "/passengers/#{@passenger1.id}"

    expect(page).to have_content(@passenger1.name)
  end

  it "I see a section of the page that displays all flight numbers of the flights for that passenger" do
    visit "/passengers/#{@passenger1.id}"

    within ".flights" do
      expect(page).to have_content(@flight1.number)
      expect(page).to have_content(@flight2.number)
    end
  end

  it "All flight numbers are links to that flight’s show page" do
    visit "/passengers/#{@passenger1.id}"

    within ".flights" do
      click_link(@flight1.number)
    end

    expect(current_path).to eq("/flights/#{@flight1.id}")
  end

  it "I can add a flight" do

    visit "/passengers/#{@passenger1.id}"

    expect(page).to have_link("Add flight")

    click_link("Add flight")

    expect(current_path).to eq("/passengers/#{@passenger1.id}/new_flight")

    fill_in :flight_number, with: @flight3.number

    click_button "Submit"

    expect(current_path).to eq("/passengers/#{@passenger1.id}")

    within ".flights" do
      expect(page).to have_content(@flight3.number)
    end
  end
end
