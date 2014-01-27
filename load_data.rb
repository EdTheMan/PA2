class LoadData

  def initialize()
    

  end
  
  def load_training(array,file,number_of_ratings_hash,timestamp_hash)
    
    
        File.readlines(file).each do |value|
       
           split_line = value.split(" ")
       
           #maps the user hash to a hash of movie_id mapped to the rating given by the user
           array[Integer(split_line[0])][Integer(split_line[1])] = (Integer(split_line[2]))
           
           #maps each movie id to its number of ratings
           number_of_ratings_hash[Integer(split_line[1])] = number_of_ratings_hash[Integer(split_line[1])] + 1
            
           #puts each movie_id's timestamps into an ARRAY mapped by the movie_id
           timestamp_hash[Integer(split_line[1])] << (Integer(split_line[3]))
           
         end
end
         
    def load_training_and_test(array,file)
         File.readlines(file).each do |value|
         split_line = value.split(" ")
         #maps the user hash to a hash of movie_id mapped to the rating given by the user
         array[Integer(split_line[0])][Integer(split_line[1])] = (Integer(split_line[2]))        
         end
    
   end
    
end