

class Exhibitionist::Shows
  attr_accessor :title, :dates, :museum, :closing_date, :days_left

  
  @@all_shows = []
  
  def self.all
    @@all_shows
  end

  def self.met_scraper

    met_shows = []

    html = open("http://www.metmuseum.org/press/exhibitions/2016/current-major-exhibitions")
    current_shows_page = Nokogiri::HTML(html)
    current_shows = current_shows_page.css("div.general-content p strong em a")
    current_shows.each do |show|
      begin
        new_show = self.new
        met_shows << new_show
        self.all << new_show
        new_show.title = show.text
        new_show.museum = Exhibitionist::Museums.find_or_create("Metropolitan Museum of Art")
        new_show.dates = show.parent.parent.next.next
        closing_date_object = Date.parse(new_show.dates.text.gsub(/^\n.+\–/, ""))
        new_show.closing_date = closing_date_object.strftime("%B %-d, %Y")
        today = Date.today
        new_show.days_left = (closing_date_object - today).to_i
        if new_show.days_left < 0
          self.all.delete(new_show)
        end
      rescue
        self.all.delete(new_show)
      end
    end
    met_shows
  end

  def self.moma_scraper

    moma_shows = []

    html = open("http://www.moma.org/calendar/exhibitions")
    current_shows_page = Nokogiri::HTML(html)
    current_shows = current_shows_page.css("ul.calendar-tile-list__section--featured li.calendar-tile")
    current_shows.each do |show|
      begin
        new_show = self.new
        moma_shows << new_show
        self.all << new_show
        new_show.title = show.css("h3").text.strip
        new_show.museum = Exhibitionist::Museums.find_or_create("MoMA")
        if show.css("p").text.strip.downcase != "ongoing"
          closing_date_object = Date.parse(show.css("p").text.gsub(/^(.+?),\s/, "").strip)
          new_show.closing_date = closing_date_object.strftime("%B %-d, %Y")
          new_show.days_left = (closing_date_object - Date.today).to_i
        else
          new_show.closing_date = "Ongoing"
          new_show.days_left = 9999
        end
        if new_show.days_left < 0
          self.all.delete(new_show)
        end
      rescue
        self.all.delete(new_show)
      end
    end
    moma_shows
  end

  def self.whitney_scraper
    
    whitney_shows = []

    html = open("http://whitney.org/Exhibitions")
    current_shows_page = Nokogiri::HTML(html)
    current_shows = current_shows_page.css("div.exhibitions div.image")
    current_shows.each do |show|
      begin
        new_show = self.new
        whitney_shows << new_show
        self.all << new_show
        new_show.title = show.css("h3 a")[0].text.gsub("â", "'").strip
        new_show.museum = Exhibitionist::Museums.find_or_create("Whitney")
        new_show.dates = show.css("h3 span")
        closing_date_object = Date.parse(new_show.dates.text.gsub(/^.+\–/, ""))
        new_show.closing_date = closing_date_object.strftime("%B %-d, %Y")
        new_show.days_left = (closing_date_object - Date.today).to_i
        if new_show.days_left < 0
          self.all.delete(new_show)
        end
      rescue
        self.all.delete(new_show)
      end

    end
   
    whitney_shows

  end

  def self.brooklyn_scraper 

    brooklyn_shows = []

    html = open("https://www.brooklynmuseum.org/exhibitions")
    current_shows_page = Nokogiri::HTML(html)

    current_shows = current_shows_page.css("div.exhibitions").xpath("//h1[1]/following-sibling::div").css("div.image-card h2")

    current_shows.each do |show|
      begin
        new_show = self.new
        brooklyn_shows << new_show
        self.all << new_show
        new_show.title = show.text
        new_show.museum = Exhibitionist::Museums.find_or_create("Brooklyn Museum")
        new_show.dates = show.parent.css("h4")
        closing_date_object = Date.parse(new_show.dates.text.strip.gsub(/^.+\–/, ""))
        new_show.closing_date = closing_date_object.strftime("%B %-d, %Y")
        new_show.days_left = (closing_date_object - Date.today).to_i
        if new_show.days_left < 0
          self.all.delete(new_show)
        end
      rescue
        self.all.delete(new_show)
      end
    end

    brooklyn_shows

  end

  def self.new_museum_scraper

    new_museum_shows = []

    html = open("http://www.newmuseum.org/exhibitions")
    current_shows_page = Nokogiri::HTML(html)
    current_shows = current_shows_page.css("div.columns div.exh a")
    current_shows.each do |show|
      begin
        new_show = self.new
        new_museum_shows << new_show
        self.all << new_show
        new_show.title = show.css("span.title").text
        new_show.museum = Exhibitionist::Museums.find_or_create("New Museum")
        new_show.dates = show.css("span.date-range")
        closing_date_object = Date.strptime("#{new_show.dates.text.gsub("Ending Soon", "").strip.gsub(/^.+\-/, "")}", "%m/%d/%y")
        new_show.closing_date = closing_date_object.strftime("%B %-d, %Y")
        new_show.days_left = (closing_date_object - Date.today).to_i 
        if new_show.days_left < 0
          self.all.delete(new_show)
        end
      rescue
        self.all.delete(new_show)
      end
    end
    
    new_museum_shows

  end


  def self.sort_by_closing_date
    self.all.sort_by { |show| show.days_left }
  end


  def closing_soon_alert
    if self.days_left < 8
      puts "CLOSING SOON!!! Hurry up, there are only"
    else

    end
  end


  def closing_info

    if self.days_left == 0
      puts "Hurry up! This show closes today!!"
    elsif self.days_left == 1
      puts "Hurry Up! This show closes tomorrow!!"
    elsif self.days_left < 8
      puts "Hurry up! This show closes in #{self.days_left} days!! It closes on #{self.closing_date}."
    elsif self.closing_date == "Ongoing"
      puts "This show is ongoing. You've got plenty of time."
    else 
      puts "This show closes in #{self.days_left} days, on #{self.closing_date}."
    end

  end

  def on_view_through

    if self.closing_date == "Ongoing"
      puts "This show is ongoing.\n\n"
    else
      puts "On view through #{self.closing_date}.\n\n"
    end
  end

  def self.scrape_all
    
    begin
      self.met_scraper
    rescue
      self.all.delete_if { |show| show.museum.name == "Metropolitan Museum of Art"}
      puts "There was a problem scraping the Met's website. Finding other shows... \n\n"
    end

    begin
      self.moma_scraper
    rescue
      self.all.delete_if { |show| show.museum.name == "MoMA"}
      puts "There was a problem scraping the MoMA's website... \n\n"
    end

    begin  
      self.whitney_scraper
    rescue
      self.all.delete_if { |show| show.museum.name == "Whitney"}
      puts "There was a problem scraping the Whitney's website... \n\n"
    end
      
    begin
      self.brooklyn_scraper
    rescue
      self.all.delete_if { |show| show.museum.name == "Brooklyn Museum"}
      puts "There was a problem scraping the Brooklyn Museum's website... \n\n"
    end

    begin  
      self.new_museum_scraper
    rescue
      self.all.delete_if { |show| show.museum.name == "New Museum"}
      puts "There was a problem scraping the New Museum's website... \n\n"
    end
  end


end