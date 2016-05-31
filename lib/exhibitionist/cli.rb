class Exhibitionist::CLI

  def call
    display_museums
    choose_museum
    choose_show
    exit
  end

  def display_museums
    puts "Welcome to the Exhibitionist."

    puts  "1. Metropolitan Museum of Art"
    puts  "2. MoMA"
    puts  "3. Whitney Museum of American Art"
    puts  "4. Guggenheim Museum"
    puts  "5. Brooklyn Museum"
    puts  "6. New Museum"
    puts  "7. MoMA PS1"
    puts  "8. Rubin Museum of Art"

    puts "Which museum would you like to view?"
  end

  def choose_museum

    input = nil

    while input != "exit"
      input = gets.strip.downcase

      if input == "1"
        Exhibitionist::Shows.met_scraper.each.with_index(1) do |show, index|
          puts "#{index}. #{show.title} - #{show.dates}"
        end

      elsif input == "2"
        puts "MoMA - Current Exhibitions:"
      elsif input == "3"
        puts "Whitney Museum - Current Exhibitions:"
      elsif input == "list"
        call
      elsif input == "back"
        call
      #elsif input == "exit"
      #  exit
      elsif input == "all"
        puts "All Current Exhibitions:"
      else
        puts "I couldn't understand that. Please enter the number of the museum you'd like to view, 'all' to list all shows, or 'exit'."
      end
    end 
  end

  def exit
    puts "Goodbye! Check back soon for updated shows."
  end


end