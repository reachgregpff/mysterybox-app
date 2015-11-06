# DIY Mystery Box by Greg Fernandes

# About the mystery box app

  - What it does
    The search is on for MasterChef contestants for 2016. If you’ve ever leapt up and yelled at the television then I highly recommend applying. --- Julie Goodwin (Masterchef ex-contestant)

    For those of you keen to give it a crack, take the Masterchef challenge from the convenience of your home: team up with other pretend-contestants and COOK LIKE A MASTERCHEF!

    Details: This app generates a box of random key ingredients, fetches recipes that match different combinations of 5 random ingredients selected by the app. A maximum of 160 recipes that match will be fetched. The user can select a recipe, save that recipe if it is the one that needs to be tried out and cooked.

# The app design and implementation
  - The Matching Algorithm to fetch recipes will total 16 searches for 5c5, 5c4, and 5c3. These 16 search requests are sent to food2fork via their API and through Ruby Gem HTTParty. Each search request fetches a maximum of 30 ranked recipes, however only the top 10 are displayed. This means a possible maximum of 160 recipes are displayed and a minimum of 0 recipes if no matching recipes are found.

  The database design consists of a table for users and another table of recipes that has all saved recipes for a user.

# Known Bugs
  - Sometimes, clicking on the 'likes' menu item throws a Nil error

# Future improvements
 
  - add an invisible cheat button if you wish to select your own ingredients
  - add a realtime timer, audio files for a countdown and occasional hoorahs/rants while cooking

## Technologies used

  - HTML5 and CSS3 for the front-end
  - Ruby with Sinatra, Ruby Gems (bcrypt, pry, etc). 
  - Postgres
  - Ruby Gem activerecord to connect with Postgres
  - Restful API from Food2Fork
  - Ruby Gem HTTParty to send/recieve Food2Fork Restful APIs
  - Chrome and Sublime editor for development

## GITHUB Link

  https://github.com/reachgregpff/mysterybox-app.git

## HEROKU hosted Link

  https://diy-mysterybox.herokuapp.com/

