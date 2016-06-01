

class Exhibitionist::Shows
  attr_accessor :title, :summary, :dates, :museum, :url, :closing_date, :days_left

  
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
      new_show = self.new
      met_shows << new_show
      self.all << new_show
      new_show.title = show.text
      new_show.museum = Exhibitionist::Museums.new("Metropolitan Museum of Art")
      new_show.url = show.attribute("href").value
      new_show.dates = show.parent.parent.next.next
      new_show.closing_date = new_show.dates.text.gsub(/^\n.+\–/, "")
      closing_date_object = Date.parse(new_show.closing_date)
      today = Date.today

      new_show.days_left = (closing_date_object - today).to_i

      #binding.pry    
    end

    met_shows

  end



  def closing_soon_alert
    if self.days_left < 8
      puts "CLOSING SOON!!! Hurry up, there are only"
    else

    end
  end

  def self.scrape_all
    self.met_scraper
  end


end