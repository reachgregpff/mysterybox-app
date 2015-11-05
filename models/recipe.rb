#maps class to the dishes table
class Recipe < ActiveRecord::Base 
  belongs_to :user   #model name here
end