require 'securerandom'
class Booking
  attr_reader :movie_id, :id, :show_id

  def initialize(movie_id:, show_id:, seat_number:)
    @id = SecureRandom.uuid
    @movie_id = movie_id
    @show_id = show_id
    @seat_number = seat_number
  end
end
