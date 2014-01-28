require_relative 'movie_data'

 z = MovieData.new("ml-100k")
  #z = MovieData.new('ml-100k',:u1) 
 z.load_data
 
 #p z.similarity(196,186)
 #p z.popularity(242)
 #p z.predict(196,242)
 start = Time.now.to_f
 z.run_test(10).mean
 p (((Time.now.to_f) - start))
#p File.readlines('u.data')[0..1]

#z.run_test(3).rms
