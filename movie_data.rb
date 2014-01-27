#Chi Ieong (Eddie) Tai
#teddy123168@gmail.com
#1/20/14
#Pito Salas, COSI 236B
#This class is used to determine the popularity of a movie and the similarity
#between users using a text file from the current directory.
#Popularity is given by the formula (Average timestamp/ SCALEAVERAGETIMESTAMP) + number of ratings
#whether a movie has good or bad reviews, it could still be considered popular
#and a movie who is older (smaller timestamp) will usually have more ratings because 
#more people get a chance to rate it, so give a slight advantage to newer movies based on SCALEAVERAGETIMESTAMP.
#Similarity is given by 1 / 1 + ((rating of user1) - (rating of user2).abs))

require_relative 'movie_test.rb'

class MovieData
  
  #initializes variables
  SCALEAVERAGETIMESTAMP = 10000000000 #2 years gives about 6 rating to popularity formula
    
  #initializes Hashes
  def initialize(arg1 = nil,arg2 = nil)
    
    
    @user_hash = Hash.new {|h,k| h[k] = Hash.new } #hash where user maps to a hash that maps movie_id to its rating by the user
    @number_of_ratings_hash = Hash.new(0) #hash that maps a movie to the number of rating it has
    @timestamp_hash = Hash.new {|h,k| h[k] = Array.new } #hash that maps movie id to an array of its timestamps of when it was rated.
    @avg_timestamp_hash = Hash.new #hash that maps the movie_id to the average timestamp of when it was rated (see popularity_list())
    @popularity_hash = Hash.new #hash that maps movie_id to its popular given by the formula (Average timestamp/ SCALEAVERAGETIMESTAMP) + number of ratings
    @similarity_hash = Hash.new(0) #hash that maps a user to a similarity score of another user, similarity = (1 / 1 + ((rating of user1) - (rating of user2).abs))
    @test_set = Hash.new {|h,k| h[k] = Hash.new } 
    @arg1 = arg1
    @arg2 = arg2
    
    
  end
  
  #returns void
  def load_data()
        
    if @arg1 == "ml-100k" and @arg2 == nil
 
        add_sets(@user_hash,'u.data')
        #p @user_hash.keys.take(5)
    
    elsif @arg1 == 'ml-100k' and @arg2 == :u1
      
        add_sets(@user_hash,'u1.base')
        add_sets2(@test_set,'u1.test')
        #p @user_hash.keys.take(5)
        
     else
    
        p "Invalid arguments"
      
     end
       
      
  end
  
  
  def add_sets(array,file)
    
       File.readlines(file).each do |value|
       
         split_line = value.split(" ")
       
         #maps the user hash to a hash of movie_id mapped to the rating given by the user
         array[Integer(split_line[0])][Integer(split_line[1])] = (Integer(split_line[2]))
         
         #maps each movie id to its number of ratings
         @number_of_ratings_hash[Integer(split_line[1])] = @number_of_ratings_hash[Integer(split_line[1])] + 1
          
         #puts each movie_id's timestamps into an ARRAY mapped by the movie_id
         @timestamp_hash[Integer(split_line[1])] << (Integer(split_line[3]))
         
       end
       
  end
  
  
  def add_sets2(array,file)
    
         #maps the user hash to a hash of movie_id mapped to the rating given by the user
         array[Integer(split_line[0])][Integer(split_line[1])] = (Integer(split_line[2]))
 
  end
  
 
  
  #takes movie_id (integer) as parameters
  #returns a number determining the popularity
  def popularity(movie_id)     
       
     #gets the average time stamp of a movie_id by getting the timestamp of all ratings and getting the average of that 
     average_time_stamp = (@timestamp_hash[movie_id].inject{ |sum, el| sum + el }.to_f / @timestamp_hash[movie_id].size)
     
     #returns the popularity given by (Average timestamp/ SCALEAVERAGETIMESTAMP) + number of ratings
     return ((average_time_stamp  / SCALEAVERAGETIMESTAMP)) + (@number_of_ratings_hash[movie_id])

  end
  
  #returns the list of popular movies
  def popularity_list

       #each key is a movie_id that maps to its average timestamp
       @timestamp_hash.each do |key, value|
          @avg_timestamp_hash[key] = (@timestamp_hash[key].inject{ |sum, el| sum + el }.to_f / @timestamp_hash[key].size) 
       end
      
       #gets all the popularity of each movie id by the formula (Average timestamp/ @scaleAvgTimestamp) + number of ratings
       @avg_timestamp_hash.each do |key, value|
          @popularity_hash[key] = ((@avg_timestamp_hash[key]  / SCALEAVERAGETIMESTAMP)) + (@number_of_ratings_hash[key])
       end
       
       #returns the list of movies from the most popular to the least popular
       return Hash[@popularity_hash.sort_by{|k, v| v}.reverse].keys
        
  end
  
  #takes two users (integers) as parameters
  #returns a float similarity
  def similarity(user1,user2)
    
    similarity = 0
    
    #loops each movie of the first user
    @user_hash[user1].each do |key, value|
     
      if(@user_hash[user2].has_key?(key)) #check to see if user2 has rated the movie or not
        
        similarity = similarity + (1.0 / (1.0+ ((value - (@user_hash[user2][key])).abs))) #if it has rated the movie then the similarity is given by (1 / 1 + ((rating of user1) - (rating of user2).abs))
        
      end
      
    end
      
    return similarity
    
  end
  
  #takes a user (integer) as input
  #returns an array of the first ten users who are most similar to the given user
  def most_similar(user)
    
      #look for each user
      @user_hash.each do |key,value|
     
        if user != key #do not include the given user
        
        @similarity_hash[key] = similarity(user,key) #hash maps user id to its similarity of the given user
        
        end
      
      end
    
    return (Hash[@similarity_hash.sort_by {|k,v| v}.reverse]).keys.take(10) #get the first ten users who have the highest similarity score
    
  end
  
end