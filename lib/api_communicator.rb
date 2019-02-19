require 'rest-client'
require 'json'
require 'pry'

def get_response_hash(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
end

def get_character_movies_from_api(character_name)
  #make the web request
  response_hash = get_response_hash('http://www.swapi.co/api/people/')

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  films = []

  response_hash["results"].each do | result_hash |
    if result_hash["name"] == character_name
      films = result_hash["films"]
    end
  end

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film

  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  films.collect do | film_url |
    get_response_hash(film_url)
  end
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each_with_index do | film, index |
    puts "#{index}."
    puts "Title: #{film["title"]}"
    puts "Episode Number: #{film["episode_id"]}"
    puts "Opening Crawl: #{film["opening_crawl"]}"
    puts "Director: #{film["director"]}"
    puts "Producer: #{film["producer"]}"
    puts "Release date: #{film["release_date"]}"
    puts "URL: #{film["url"]}"
    puts "\n\n"

  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
