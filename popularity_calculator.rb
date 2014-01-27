class PopularityCalculator
  
  #initializes variables
  SCALEAVERAGETIMESTAMP = 10000000000 #2 years gives about 6 rating to popularity formula
  
  def initialize()
    
  end
  
  #takes movie_id (integer) as parameters
  #returns a number determining the popularity
  def popularity(movie_id,timestamp_hash,number_of_ratings_hash)     
       
     #gets the average time stamp of a movie_id by getting the timestamp of all ratings and getting the average of that 
     average_time_stamp = (timestamp_hash[movie_id].inject{ |sum, el| sum + el }.to_f / timestamp_hash[movie_id].size)
     
     #returns the popularity given by (Average timestamp/ SCALEAVERAGETIMESTAMP) + number of ratings
     return ((average_time_stamp  / SCALEAVERAGETIMESTAMP)) + (number_of_ratings_hash[movie_id])

  end
  
  #returns the list of popular movies
  def popularity_list(timestamp_hash)


       avg_timestamp_hash = Hash.new #hash that maps the movie_id to the average timestamp of when it was rated (see popularity_list())
       #each key is a movie_id that maps to its average timestamp
       timestamp_hash.each do |key, value|
          avg_timestamp_hash[key] = (timestamp_hash[key].inject{ |sum, el| sum + el }.to_f / @timestamp_hash[key].size) 
       end
      
       popularity_hash = Hash.new #hash that maps movie_id to its popular given by the formula (Average timestamp/ SCALEAVERAGETIMESTAMP) + number of ratings
       #gets all the popularity of each movie id by the formula (Average timestamp/ @scaleAvgTimestamp) + number of ratings
       avg_timestamp_hash.each do |key, value|
          popularity_hash[key] = ((avg_timestamp_hash[key]  / SCALEAVERAGETIMESTAMP)) + (number_of_ratings_hash[key])
       end
       
       #returns the list of movies from the most popular to the least popular
       return Hash[popularity_hash.sort_by{|k, v| v}.reverse].keys
        
  end
  
  
end