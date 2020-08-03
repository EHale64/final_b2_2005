class Flight < ApplicationRecord
  belongs_to :airline
  has_many :passenger_flights
  has_many :passengers, through: :passenger_flights
  
  def minors
    require "pry"; binding.pry
  end
end
