require 'active_record'

options = {
  adapter: 'postgresql',
  username: 'greg',       #you probably dont need this
  database: 'mysterybox'
}

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || options)
