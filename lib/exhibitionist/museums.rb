class Exhibitionist::Museums
  attr_accessor :name

  @@all = []

  def self.all
    @@all 
  end

  def initialize(name)
    @name = name
    self.class.all << self
  end
end