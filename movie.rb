class Movie
  
  attr_accessor :id,:number_of_ratings,:timestamps
  
  def initialize(id)
    
    @id = id
    @number_of_ratings = 0
    @timestamps = Array.new 
    
    
  end
  
  def get_id()
    
    return @id
    
  end
end