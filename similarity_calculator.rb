class SimilarityCalculator

  def initialize()
    
  end


  #takes two users (integers) as parameters
  #returns a float similarity
  def similarity(user1,user2,user_hash)
    
    similarity = 0
    
    #loops each movie of the first user
    user_hash[user1].each do |key, value|
     
      if(user_hash[user2].has_key?(key)) #check to see if user2 has rated the movie or not
        
        similarity = similarity + (1.0 / (1.0+ ((value - (user_hash[user2][key])).abs))) #if it has rated the movie then the similarity is given by (1 / 1 + ((rating of user1) - (rating of user2).abs))
        
      end
      
    end
      
    return similarity
    
  end


  
  #takes a user (integer) as input
  #returns an array of the first ten users who are most similar to the given user
  def most_similar(user,user_hash,similarity_hash)
    
      #look for each user
      user_hash.each do |key,value|
     
        if user != key #do not include the given user
        
        similarity_hash[key] = similarity(user,key,user_hash) #hash maps user id to its similarity of the given user
        
        end
      
      end
    
    return (Hash[similarity_hash.sort_by {|k,v| v}.reverse]).keys.take(10) #get the first ten users who have the highest similarity score
    
  end



end