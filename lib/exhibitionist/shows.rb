class Exhibitionist::Shows
  attr_accessor :title, :summary, :dates, :museum, :url

  def self.met_scraper

    met_shows = []

    html = open("http://www.metmuseum.org/press/exhibitions/2016/current-major-exhibitions")
    current_shows_page = Nokogiri::HTML(html)
    

    current_shows = current_shows_page.css("div.general-content p strong em a")
    
    current_shows.each do |show|
      new_show = self.new
      met_shows << new_show

      new_show.title = show.text
      new_show.museum = "Met"
      
      new_show.dates = show.parent.parent.next.next
      #binding.pry
    end

    met_shows

  end


end