class Exhibitionist::CLI

  def initialize
    
    puts "Welcome to the Exhibitionist.\n"
    puts "Finding shows...\n\n"
    Exhibitionist::Shows.scrape_all
    
  end

  def call
    display_shows
    choose_exhibition
    
    #exit
  end



  def display_shows
   
    
    Exhibitionist::Shows.sort_by_closing_date.first(10).each.with_index(1) do |show, index|
      puts "#{index}. #{show.title}"
    end

    puts "\nHere are 10 shows closing soon, listed by which is closing soonest.\n\n"

  end


  def choose_exhibition

      puts "Pick a show you're interested in, or type 'all' to see a list of every exhibition."
      puts "You can also type 'museums' to see a list of museums currently represented."

      input = gets.strip.downcase

      if input.to_i > 0
        input = input.to_i - 1

        exhibit = Exhibitionist::Shows.sort_by_closing_date[input]
        puts "\n\n#{exhibit.title}\n\n"
        puts "at the #{exhibit.museum.name}\n\n"
        
        exhibit.closing_info
        #puts "Closes on #{exhibit.closing_date}\n\n"

        #puts "#{exhibit.closing_soon_alert}#{exhibit.days_left} days left to see this show!\n\n"

        puts "\n\nOther shows at this museum:\n\n"

        Exhibitionist::Shows.all.each.with_index(1) do |show, index|
          if show.museum.name == exhibit.museum.name && show.title != exhibit.title
            puts show.title
            show.on_view_through
          else
          end
        end

        choose_again

      elsif input == "museums"
        puts "The following museums are currently represented:\n\n"
        choose_by_museum
      elsif input == "all"
        all_shows
      elsif input == "exit"
        exit          
      else
        puts "I couldn't understand that."
        choose_exhibition
      end
    
  end

  def choose_again
    puts "Would you like to learn about another show? (Y/N)"
    input = gets.strip.downcase
    if input == "y"
      call
    elsif input == "n" or input == "exit"
      exit
    else
      puts "I couldn't understand that. Please enter Y or N."
      choose_again
    end
      
  end

  def exit
    puts "Goodbye! Check back soon for updated shows."
  end

  def all_shows
    puts "All Current Exhibitions:"
      Exhibitionist::Shows.sort_by_closing_date.each.with_index(1) do |show, index|
        puts "#{index}. #{show.title}"
      end
    choose_exhibition
  end

  def choose_by_museum
    Exhibitionist::Museums.all.each.with_index(1) do |museum, index|
      puts "#{index}. #{museum.name}"
    end
    puts "\nWhich museum would you like to view? Or type 'back' to see the master exhibition list."
    input = gets.strip.downcase

    if input.to_i > 0
      input = input.to_i - 1

      puts "\n\nShows at the #{Exhibitionist::Museums.all[input].name}:\n\n"

      Exhibitionist::Shows.sort_by_closing_date.each.with_index(1) do |show, index|
        if show.museum.name == Exhibitionist::Museums.all[input].name
          puts show.title
          show.on_view_through
        end
      end
      choose_again
    elsif input == "back"
      display_shows
    else
      puts "I could't understand that."
      choose_again
    end
  end


end