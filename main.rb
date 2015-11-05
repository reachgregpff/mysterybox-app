     
require 'sinatra'
#require 'sinatra/reloader'
#require 'pry'
require 'pg'
require 'httparty'


require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/recipe'

enable :sessions

ingredients = ["duck", "lamb", "chicken", "quail", "turkey", "beef", "pork", 
    "bacon", "sausage", "chorizo",
    "salmon", "tuna", "prawn", "lobster", "scallop", "oyster", "mussels", "octopus", "snapper", "trout", "squid","sea bass", "crab",
    "ginger", "garlic", "galangal", "lemon", 
    "chocolate", "raspberry", "blueberry", "apple", "pear", "pineapple",
    "leek", "kale", "asparagus", "spinach", "basil",
    "cheese", "cream", "yoghurt", "butter", "mozzarella", "ricotta",
    "coriander", "dil", "rosemary", "sage", "bay leaf", "parsley", "celery", "thyme",
    "soy", "honey", "mushroom", "miso", "wine",
    "tomato", "onion", "capsicum", "olive", "eggs", "chilli", "celeriac",
    "eggplant", "potato", "beans", "avocado", "coconut", "peanut"
  ]

random_ingredients = nil

#F2F_KEY = "fc17a9b17498703b8a27a351123f3558"
#F2F_KEY = "4c0f14cbb97734b74bd7d48b308b586e"
#F2F_KEY = "7b5f61521a1edd1ed28d8f8cfcd37e74"
#F2F_KEY = "c4811bec803fc780b8fd6f6c55aa19fa"
F2F_KEY = "c4811bec803fc780b8fd6f6c55aa19f"

save_recipe = nil

current_recipe_ingredients_combo = nil
current_recipe = nil


before do


end

helpers do

  def link(label, href)
    "<a href='#{ href }'>#{ label}</a> "
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    #if current_user
    #  true
    #else
    #  false
    #end

    !!current_user  #code replaces if above

  end

end

after do
  ActiveRecord::Base.connection.close
end


# LANDING PAGE ----------------------------------------------------------------------------------
get '/' do


  erb :index
end


# GENERATE INGREDIENTS in the mystery box ----------------------------------------------------------------------------------
get '/mysterybox' do

  random_ingredients = ingredients.sample(5)

  @mystery_ingredients = random_ingredients


  erb :mysterybox
end


# FETCH recipes ----------------------------------------------------------------------------------
get '/recipes' do

  @combo5 = random_ingredients
  @combo4 = random_ingredients.combination(4).to_a
  @combo3 = random_ingredients.combination(3).to_a

  @start_time =  Time.now
  @results5 = nil
  @results4 = []
  @results3 = []

  #combo 5

  query_string = "http://food2fork.com/api/search?key=" + F2F_KEY + "&sort=r&q=" + @combo5.join(",")
  @results5 = HTTParty.get(query_string)

  #combo 4
  for i in 0..(@combo4.length-1) do
    query_string = "http://food2fork.com/api/search?key=" + F2F_KEY + "&sort=r&q=" + @combo4[i].join(",")
    @results4[i] = HTTParty.get(query_string)
  end

  #combo 3
  for i in 0..(@combo3.length-1) do
    query_string = "http://food2fork.com/api/search?key=" + F2F_KEY + "&sort=r&q=" + @combo3[i].join(",")
    @results3[i] = HTTParty.get(query_string)
  end

  @end_time = Time.now


  erb :recipes
end


# Display 1 recipe details----------------------------------------------------------------------------------
get '/recipe/:id' do

  @ingredients_combo = params[:combo]

  query_string = "http://food2fork.com/api/get?key=" + F2F_KEY + "&rId=" + params[:id]
  @recipe = HTTParty.get(query_string)

  #Create Recipe object for later use in '/like'
  
  #save_recipe = Recipe.new(recipe_id: JSON.parse(@recipe)["recipe"]["recipe_id"],
  #                        username: session[:username],          #get username of this person from session username
  #                        title: JSON.parse(@recipe)["recipe"]["title"],
  #                        social_rank: JSON.parse(@recipe)["recipe"]["social_rank"],
  #                        image_url: JSON.parse(@recipe)["recipe"]["image_url"],
  #                        ingredients: JSON.parse(@recipe)["recipe"]["ingredients"].to_json,  #not sure why we should un-JSON and then JSON again
  #                        publisher: JSON.parse(@recipe)["recipe"]["publisher"],
  #                        source_url: JSON.parse(@recipe)["recipe"]["source_url"]
  #)                      

  current_recipe = @recipe    # save for a refresh of this '/recipe' page
  current_recipe_ingredients_combo = params[:combo]  # save for a refresh of this '/recipe' page

  save_recipe = Recipe.new(recipe_id: JSON.parse(@recipe)["recipe"]["recipe_id"],
                           username: session[:username],          #get username of this person from session username
                           recipe: @recipe)

  erb :recipe
end


# Display 1 recipe details----------------------------------------------------------------------------------
get '/like/:recipe_id' do

  if !(Recipe.find_by(username: session[:username], recipe_id: params[:recipe_id]))  #save only if this user has not saved this recipe earlier
    
    save_recipe.save

  end

  @ingredients_combo = current_recipe_ingredients_combo
  @recipe = current_recipe

  erb :recipe

end

# Display all likes for this user ----------------------------------------------------------------------------------
get '/likes' do

  @likes = Recipe.where(username: session[:username])
    
  erb :likes

end



#-----------------------
# This is Authentication
#-----------------------

#show signup form
get '/signup' do

  erb :signup

end

#creating a session
post '/signup' do

  #raise over here
  user = User.find_by(username: params[:username])

  if user 
    #user already existing
    redirect to '/signup'

  else
    #create new user
    new_user = User.new(username: params[:username], password: params[:password])
    new_user.save
    redirect to '/login'
  end

end


#show login form
get '/login' do

  erb :login

end

#creating a session
post '/session' do

  #raise over here
  user = User.find_by(username: params[:username])

  if user && user.authenticate(params[:password])
    #create the session
    #redirect the user
    session[:user_id] = user.id
    session[:username] = user.username

    puts "in /session"
    puts session[:user_id]
    puts session[:username]
    redirect to '/'

  else
    #redirect user
    redirect to '/login'
  end

end

#deleting a session
get '/logout' do

  #raise over here

  session[:user_id] = nil
  session[:username] = nil
  redirect to '/'
  
end

#deleting a session
delete '/session' do

  #raise over here

  #session[:user_id] = nil
  #session[:username] = nil
  redirect to '/login'
  
end





