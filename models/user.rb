class User < ActiveRecord::Base

  has_secure_password  #give us the password
  has_many :recipes  #plural of model name here

end


#user = User.new
#user.email = 'dt@ga.co'
# user.password = 'pudding'
#user.save
#User.count
# user.authenticate('pudding')   #returns the user
