class Exhibitionist::CLI

  def initialize
    Exhibitionist::Shows.all.clear
    Exhibitionist::Shows.scrape_all
  end

  def call
    display_shows
    choose_exhibition
    
    #exit
  end

  def display_shows
    puts "Welcome to the Exhibitionist.\n"
    puts "These shows are closing soon!"
    
    Exhibitionist::Shows.all.each.with_index(1) do |show, index|
      puts "#{index}. #{show.title}"
    end

    

    puts "Which show are you interested in?"
  end


# ##### CHANGE TO THIS TO SELECT A SHOW ##### #

  def choose_exhibition

      input = gets.strip

      if input.downcase.to_i > 0
        input = input.downcase.to_i - 1

        exhibit = Exhibitionist::Shows.all[input]
        puts "#{exhibit.title}"
        puts "at #{exhibit.museum.name}\n\n"
        puts "Closes on #{exhibit.closing_date}\n\n"

        puts "#{exhibit.closing_soon_alert}#{exhibit.days_left} days left to see this show!\n\n"

        puts "Other shows at this museum:"

        Exhibitionist::Shows.all.each.with_index(1) do |show, index|
          if show.museum.name == exhibit.museum.name && show.title != exhibit.title
            puts show.title
            puts "On view through #{show.closing_date}\n\n"
          else
          end
        end

        choose_again

      #if input.downcase.to_i - 1 == 0
      #  puts "#{Exhibitionist::Shows.all[0].title}"
      #  puts "at #{Exhibitionist::Shows.all[0].museum.name}\n\n"
       # puts "Closes on #{Exhibitionist::Shows.all[0].closing_date}\n\n"
       # puts "Other shows at this museum:"

       # Exhibitionist::Shows.all.each.with_index(1) do |show, index|
       #   if show.museum.name == Exhibitionist::Shows.all[0].museum.name
       #     puts "#{index}. #{show.title}"
       #     puts "On view through #{show.closing_date}\n\n"
       #   else
       #   end
       # end
       

      #elsif input.downcase.to_i - 1 == 1
      #  puts "#{Exhibitionist::Shows.all[1].title}"
      #  puts "at #{Exhibitionist::Shows.all[1].museum.name}"
      #  puts "Closes on #{Exhibitionist::Shows.all[1].closing_date}"

      #elsif input == "3"
      #  puts "Whitney Museum - Current Exhibitions:"
      #elsif input == "list"
      #  call
      #elsif input == "back"
      #  call
      #elsif input == "exit"
      #  exit
      elsif input == "all"
        puts "All Current Exhibitions:"
      elsif input == "exit"
        exit          
      else
        puts "I couldn't understand that. Please enter the number of the museum you'd like to view, 'all' to list all shows, or 'exit'."
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

  def choose_again
    puts "Would you like to learn about another show? (Y/N)"
    input = gets.strip.downcase
    if input == "y"
      self.class.new.call
    elsif input == "n" or input == "exit"
      exit
    else
      puts "I couldn't understand that. Please enter Y or N."
    end
      
  end

  def exit
    puts "Goodbye! Check back soon for updated shows."
  end


end