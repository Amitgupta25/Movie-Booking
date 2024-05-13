require_relative 'movie'
require_relative 'ticketing_system'

def display_menu
  puts "\nWelcome to Movie Ticket Booking Platform!"
  puts "What would you like to do?"
  puts "1. Available Movies"
  puts "2. Book Ticket"
  puts "3. Cancel Ticket"
  puts "4. Available Seats"
  puts "5. Exit"
end

def view_available_movies
  @ticketing_system.available_movies
end

def booking_system_movie(movie_id)
  @ticketing_system.movie_list.find {|movie| movie.id == movie_id }
end

def is_valid_movie?(movie_id)
  if movie_id < 0 || movie_id > @ticketing_system.movie_list.length
    puts "Invalid movie number. Please try again."
    return false
  end
  true
end

def is_valid_show_time?(timing_index, movie_id)
  if timing_index < 0 || timing_index >= booking_system_movie(movie_id).show_timings.length
    puts "Invalid show timing number. Please try again."
    return false
  end
  true
end

def book_ticket
  view_available_movies
  print "Enter the movie number: "
  movie_id = gets.chomp.to_i
  return unless is_valid_movie?(movie_id)

  @ticketing_system.available_show_timings(movie_id)
  print "Enter the show timing: "
  timing_index = gets.chomp.to_i - 1
  return unless is_valid_show_time?(timing_index, movie_id)

  @ticketing_system.book_ticket(timing_index, movie_id)
end

def cancel_ticket
  unless @ticketing_system.bookings.empty?
    @ticketing_system.booked_seats
    print "Enter booking number to cancel the Booking: "
    booking_id = gets.chomp
    @ticketing_system.cancel_ticket(booking_id)
  else
    puts "No booking found"
  end
end

def show_seats_available
  view_available_movies
  print "Enter the movie: "
  movie_id = gets.chomp.to_i
  return unless is_valid_movie?(movie_id)

  @ticketing_system.available_show_timings(movie_id)
  print "Enter the show timing: "
  timing_index = gets.chomp.to_i - 1
  return unless is_valid_show_time?(timing_index, movie_id)

  booking_system_movie(movie_id).show_seats_available(timing_index)  
end

@ticketing_system = TicketingSystem.new

# To create the movies for listing
movie1 = Movie.new(1, "Godfather", ["10:00 AM", "2:00 PM", "6:00 PM"], 60)
movie2 = Movie.new(2, "Bad Guy", ["11:00 AM", "2:00 PM", "5:00 PM"], 40)

@ticketing_system.add_movie(movie1)
@ticketing_system.add_movie(movie2)

loop do
  display_menu
  print "Enter your choice: "
  choice = gets.chomp.to_i

  case choice
  when 1
    view_available_movies
  when 2
    book_ticket
  when 3
    cancel_ticket
  when 4
    show_seats_available
  when 5
    puts "Thanks for Visiting the Platform. Have a great day!"
    break
  else
    puts "Invalid Entry. Please try again."
  end
end
