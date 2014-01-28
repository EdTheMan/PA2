require_relative 'movie.rb'

class Movielist
  
  def initialize ()
    
    @list = Array.new
    
  end
  
  def add_movie_if_does_not_exist(movie_id)
    if(get_movie(movie_id) == nil)
    @list << Movie.new(movie_id)
    end
  end
  
  def get_movie(movie_id)
    
    if( @list.find_index {|item| item.id == movie_id} != nil)
      
      return @list[@list.find_index {|item| item.id == movie_id}]

    end
    return nil
    
  end
  
  def add_movie_rating(movie_id)
    
     get_movie(movie_id).number_of_ratings += 1
    
  end
  
end