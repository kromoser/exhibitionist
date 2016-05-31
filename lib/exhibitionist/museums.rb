class Exhibitionist::Museums
  


  def self.met_scraper

    met_shows = []

    html = open("http://www.metmuseum.org/press/exhibitions/2016/current-major-exhibitions")
    current_shows_page = Nokogiri::HTML(html)

    current_shows = current_shows_page.css("div.general-content p strong em a")
    
    current_shows.each do |show|
      new_show = self.new
      met_shows << new_show
      new_show.title



    
  end

end