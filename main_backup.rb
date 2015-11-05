     
require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'httparty'

get '/' do

  #HTTParty.get("http://food2fork.com/api/search?key=fc17a9b17498703b8a27a351123f3558&q=chocolate, lamb, lime")

  #random_ingredients = ["lamb", "orange", "chocolate", "hummus", "feta"]
    #=> [["lamb", "orange", "chocolate"],
 #["lamb", "orange", "hummus"],
 #["lamb", "orange", "feta"],
 #["lamb", "chocolate", "hummus"],
 #["lamb", "chocolate", "feta"],
 #["lamb", "hummus", "feta"],
 #["orange", "chocolate", "hummus"],
 #["orange", "chocolate", "feta"],
 #["orange", "hummus", "feta"],
 #["chocolate", "hummus", "feta"]]

 random_ingredients = ["duck", "orange", "raspberry", "cinnamon", "potato"]

  #F2F_KEY = "fc17a9b17498703b8a27a351123f3558"
  F2F_KEY = "4c0f14cbb97734b74bd7d48b308b586e"

  @combo5 = random_ingredients
  @combo4 = random_ingredients.combination(4).to_a
  @combo3 = random_ingredients.combination(3).to_a
  @combo2 = random_ingredients.combination(2).to_a

  @start_time =  Time.now
  @results5 = nil
  @results4 = []
  @results3 = []
  @results2 = []



#combo 5

  query_string = "http://food2fork.com/api/search?key=" + F2F_KEY + "&sort=r&q=" + @combo5.join(", ")
  @results5 = HTTParty.get(query_string)

#combo 4
for i in 0..(@combo4.length-1) do

  query_string = "http://food2fork.com/api/search?key=" + F2F_KEY + "&sort=r&q=" + @combo4[i].join(", ")
  @results4[i] = HTTParty.get(query_string)

end

#combo 3
for i in 0..(@combo3.length-1) do

  query_string = "http://food2fork.com/api/search?key=" + F2F_KEY + "&sort=r&q=" + @combo3[i].join(", ")
  @results3[i] = HTTParty.get(query_string)

end

#combo 2
#for i in 0..(@combo2.length-1) do
#
#  query_string = "http://food2fork.com/api/search?key=fc17a9b17498703b8a27a351123f3558&q=" + @combo2[i].join(", ")
#  @results2[i] = HTTParty.get(query_string)
#
#end

  @end_time = Time.now

  #binding.pry

  #puts JSON.parse(@results3[5])["recipes"].first


  erb :index
end





