class PassengerFlightsController < ApplicationController

  def new
    @passenger = Passenger.find(params[:id])
  end

  def create
    @passenger = Passenger.find(params[:id])
    flight = Flight.where(number: params[:flight_number]).take
    passenger_id = params[:id]
    PassengerFlight.create(passenger_id: params[:id], flight_id: flight.id)
    redirect_to "/passengers/#{@passenger.id}"
  end

  # private
  # def passenger_flight_params
  #   params.permit()
  # end
end
