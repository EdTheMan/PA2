require_relative 'movie_data2'

z = MovieData.new("ml-100k")

z.run_test(3).rms
