require 'rest-client'
require 'json'
require 'pry'

def get_response_hash (variable)
  #makes the web request
  response_string = RestClient.get(variable)
  response_hash = JSON.parse(response_string)
end

def collect_the_people
  get_response_hash('http://www.swapi.co/api/people/')
end

def collect_the_films
  
end

def get_character_movies_from_api(character_name)
  # iterate over the response hash to find the collection of `films` for the given `character`
  character_films = []
  collect_the_people["results"].each do |character_info_list|
    if character_info_list["name"].downcase.include? character_name
        character_films = character_info_list["films"]
    end
  end
  # collect those film API urls, make a web request to each URL to get the info for that film
  character_films.collect do |film_URL|
     get_response_hash(film_URL)
  end
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
