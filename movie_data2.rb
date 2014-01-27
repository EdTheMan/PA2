require_relative 'movie_test.rb'

class MovieData

  def initialize(arg1 = nil,arg2 = nil)
  
    @user_hash = Hash.new {|h,k| h[k] = Hash.new } #hash where user maps to a hash that maps movie_id to its rating by the user
    @test_set = Hash.new {|h,k| h[k] = Hash.new } #hash where user maps to a hash that maps movie_id to its rating by the user
    @similarity_hash = Hash.new(0) #hash that maps a user to a similarity score of another user, similarity = (1 / 1 + ((rating of user1) - (rating of user2).abs))
    @ratings = File.readlines('u1.test')  
    
    if arg1 == "ml-100k" and arg2 == nil
        
       lines = File.readlines('u.data')  
       #p lines[0].split(" ")
       for x in 0..99999
          #maps the user hash to a hash of movie_id mapped to the rating given by the user
          @user_hash[Integer(lines[x].split(" ")[0])][Integer(lines[x].split(" ")[1])] = (Integer(lines[x].split(" ")[2]))
       end    
           
      
    elsif arg1 == 'ml-100k' and arg2 == :u1
    
    lines = File.readlines('u1.base')  
    lines2 = File.readlines('u1.test')  
    
       for x in 0..79999
          #maps the user hash to a hash of movie_id mapped to the rating given by the user
          @user_hash[Integer(lines[x].split(" ")[0])][Integer(lines[x].split(" ")[1])] = (Integer(lines[x].split(" ")[2]))
       end 
       for x in 0..19999
          #maps the user hash to a hash of movie_id mapped to the rating given by the user
          @test_set[Integer(lines2[x].split(" ")[0])][Integer(lines2[x].split(" ")[1])] = (Integer(lines2[x].split(" ")[2]))
       end  
    
    else
    
      p "Invalid arguments"
    
    end
  
    #p @test_set.keys.take(10)
  
  
  end
  
  def rating(u,m)
  
    if @user_hash[u][m] == nil
      
      return 0 
      
    else
      
      return @user_hash[u][m]  
      
    end
    
    
  
  end


  def predict(u,m)
    
    most_similar_users = most_similar(u)
    
    #p most_similar_users
    
    total_ratings = 0.0
    number_of_ratings = 0.0
    
    most_similar_users.each do |key|
    
      #p @user_hash[key][m]
      if @user_hash[key][m] != nil
        total_ratings += @user_hash[key][m]
        number_of_ratings += 1
      end
    
    end
    
    if(number_of_ratings != 0.0)
    return total_ratings/number_of_ratings
    else
    return 0.0
    end
    
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
  
  result_object = MovieTest.new
  
  for x in 0..(k-1)
    
    dummy = @ratings[x].split(" ")
    result_object.store_result(dummy[0],dummy[1],dummy[2],predict(Integer(dummy[0]),Integer(dummy[1])))
  
  end
  
  return result_object
  
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
