class LoadData

  def initialize()
    
    @number_of_ratings_hash = Hash.new(0) #hash that maps a movie to the number of rating it has
    @timestamp_hash = Hash.new {|h,k| h[k] = Array.new } #hash that maps movie id to an array of its timestamps of when it was rated.
    
  end
  
  def load(array,file,addorno)
    
    
      if addorno == true
        File.readlines(file).each do |value|
       
           split_line = value.split(" ")
       
           #maps the user hash to a hash of movie_id mapped to the rating given by the user
           array[Integer(split_line[0])][Integer(split_line[1])] = (Integer(split_line[2]))
           
           #maps each movie id to its number of ratings
           @number_of_ratings_hash[Integer(split_line[1])] = @number_of_ratings_hash[Integer(split_line[1])] + 1
            
           #puts each movie_id's timestamps into an ARRAY mapped by the movie_id
           @timestamp_hash[Integer(split_line[1])] << (Integer(split_line[3]))
           
         end
         
         
       else
         
         File.readlines(file).each do |value|
         split_line = value.split(" ")
          #maps the user hash to a hash of movie_id mapped to the rating given by the user
           array[Integer(split_line[0])][Integer(split_line[1])] = (Integer(split_line[2]))
           
         end
    
        end
   end
    
end