class Exhibitionist::CLI

  def call
    display_shows
    choose_exhibition
    
    exit
  end

  def display_shows
    puts "Welcome to the Exhibitionist.\n"
    puts "These shows are closing soon!"
    #Exhibitionist::Shows.met_scraper
    Exhibitionist::Shows.all.each.with_index(1) do |show, index|
      puts "#{index}. #{show.title}"
    end

    

    puts "Which show are you interested in?"
  end


# ##### CHANGE TO THIS TO SELECT A SHOW ##### #

  def choose_exhibition

    input = nil

    while input != "exit"
      input = gets.strip.downcase.to_i - 1

      if input == 0
        puts "#{Exhibitionist::Shows.all[0].title}"
        puts "Closes on #{Exhibitionist::Shows.all[0].closing_date}"

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

  def choose_show
    puts "What show would you like more info about?"
    input = gets.strip.to_i - 1
    puts @museum_id[input].title
    #puts @museum_id[input].dates
    puts "This show closes on #{@museum_id[input].closing_date}"
    puts 
   


  end

  def exit
    puts "Goodbye! Check back soon for updated shows."
  end


end