class Exhibitionist::Museums
  
  def self.met_hours
    hours_page = Nokogiri::HTML(open("http://www.metmuseum.org/visit/met-fifth-avenue"))

    hours = hours_page.css("div.rich-text p")[1].text
  end



end