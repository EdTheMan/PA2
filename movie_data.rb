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
require_relative 'similarity_calculator'
require_relative 'popularity_calculator'
require_relative 'load_data'

class MovieData
  
  
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
    @popularity_calculator = PopularityCalculator.new
    @similarity_calculator = SimilarityCalculator.new
    @load_data = LoadData.new
    
    
  end
  
  #returns void
  def load_data()
    
    
    if @arg1 == "ml-100k" and @arg2 == nil
 
        @load_data.load_training(@user_hash,'u.data',@number_of_ratings_hash,@timestamp_hash)
        p @user_hash.keys.take(5)
    
    elsif @arg1 == 'ml-100k' and @arg2 == :u1
      
        @load_data.load_training(@user_hash,'u1.base',@number_of_ratings_hash,@timestamp_hash)
        @load_data.load_training_and_test(@test_set,'u1.test')
        #p @test_set.keys.take(12)
        
     else
    
        p "Invalid arguments"
      
     end
       
      
  end
  
  
 
  
  def rating(u,m)
        
    if @user_hash[u][m] != nil
      return @user_hash[u][m]   
    end
    return 0
  end


  def predict(u,m)
    
   
    total_ratings = 0.0
    number_of_ratings = 0.0
    
    most_similar(u).each do |key|
      if @user_hash[key][m] != nil
        total_ratings += @user_hash[key][m]
        number_of_ratings += 1
      end   
    end
    
    if(number_of_ratings != 0.0)
    return total_ratings/number_of_ratings
    end
    return 0.0
    
  end

  def movies(u)
    p @user_hash[u].keys
  end
  
  def viewers(m)
    users = Array.new
    @user_hash.each do |key,value|
         if(value.has_key?(m))
         users << key       
         end          
    end  
    return users   
  end

def run_test(k)
  
  #result_object = MovieTest.new 
  result_object = MovieTest.new
  File.readlines('u1.test')[0..(k-1)].each do |value|
    dummy = value.split(" ")
    result_object.store_result(dummy[0],dummy[1],dummy[2],predict(Integer(dummy[0]),Integer(dummy[1]))) 
  end 
  return result_object
  
end
  
  def popularity(movie_id)
    
    @popularity_calculator.popularity(movie_id,@timestamp_hash,@number_of_ratings_hash)
    
  end
  
  def popularity_list()
    
    @popularity_calculator.popularity_list(@timestamp_hash)
    
  end
  
  
  def similarity(user1,user2)
    
    @similarity_calculator.similarity(user1,user2,@user_hash)
    
  end
  
  def most_similar(user)
    
    @similarity_calculator.most_similar(user,@user_hash,@similarity_hash)
    
  end
  
  

  
end