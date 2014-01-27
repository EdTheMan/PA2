class MovieTest
  
  def initialize()
    
    @list_of_results = Array.new
    
  end
  
  
  def store_result(user,movie,rating,prediction)
    
    @list_of_results << (Array.new << user << movie <<rating << prediction)
    
  end
  
  def mean
    
    prediction_error = Array.new
    p @list_of_results
    
    @list_of_results.each do |value|
      
      prediction_error <<  ( ((value[3].to_f) - (value[2].to_f)) / (value[2].to_f) ).abs
      
    end
    
    p (prediction_error.inject{ |sum, el| sum + el }.to_f / prediction_error.size)
    
  end
  
  
  def stddev 
    
    prediction_error = Array.new
    
     @list_of_results.each do |value|
      
        prediction_error <<  ( ((value[3].to_f) - (value[2].to_f)) / (value[2].to_f) ).abs
      
     end
    
    p prediction_error
    p standard_deviation(prediction_error)
    
  end
  
  def rms
    
     prediction_error = Array.new
    
     @list_of_results.each do |value|
      
        prediction_error <<  ( ((value[3].to_f) - (value[2].to_f)) / (value[2].to_f) ).abs
      
     end
    
     rms = 0
     index = 0
      
     prediction_error.each do |value|
       
        rms += (value * value)
        index += 1
       
     end
     
     p prediction_error
     p (Math.sqrt(rms/index))
    
  end
  
  def to_a 
    
     @list_of_results.each do |value|
      
        prediction_error <<  ( ((value[3].to_f) - (value[2].to_f)) / (value[2].to_f) ).abs
      
     end
     
     p prediction_error
    
    
  end
  
  
  
    #  sum of an array of numbers
  def sum(array)
    return (array).inject(0){|acc,i|acc +i}
  end
 
  #  average of an array of numbers
  def average(array)
    return sum(array)/(array).length.to_f
  end
 
  #  variance of an array of numbers
  def sample_variance(array)
    avg = average(array)
    sum = (array).inject(0){|acc,i|acc +(i-avg)**2}
    return(1/(array).length.to_f*sum)
  end
 
  #  standard deviation of an array of numbers
  def standard_deviation(array)
    return Math.sqrt(sample_variance(array))
  end
  
  
  
end