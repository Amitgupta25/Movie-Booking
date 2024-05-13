require_relative 'booking'

class Movie
  attr_reader :id, :title, :show_timings, :total_seats, :available_seats

  def initialize(id, title, show_timings, total_seats)
    @id = id
    @title = title
    @show_timings = show_timings
    @total_seats = total_seats
    @available_seats = Array.new(show_timings.length) { total_seats }
  end

  def display_details
    puts "Title: #{title}"
    puts "Show Timings: #{show_timings.join(", ")}"
  end

  # Method for showing available seats
  def show_seats_available(show_index)
    puts "Available seats for #{show_timings[show_index]}: #{@available_seats[show_index]}"
  end
end
