class Exhibitionist::Museums
  attr_accessor :name

  @@all = []

  def self.all
    @@all 
  end

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.create(name)
    self.new(name)
    self.all << self
  end

  def self.find_by_name(name)
    self.all.find do |object|
      object.name == name
    end
  end

  def self.find_or_create(name)
    self.find_by_name(name) ? self.find_by_name(name) : self.new(name)
  end


end