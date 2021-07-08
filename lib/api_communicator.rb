require 'rest-client'
require 'json'
require 'pry'

def get_response_hash(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
end

def get_character_movies_from_api(character_name)
  #make the web request
  # response_string = RestClient.get('http://www.swapi.co/api/people/')
  # response_hash = JSON.parse(response_string)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  films_arr = []
  get_response_hash('http://www.swapi.co/api/people/')["results"].each do |x|
    if x["name"] == character_name
      films_arr = x["films"]
      # binding.pry
    end
  end

  films_arr.collect do |x|
    # response_string = RestClient.get(x)
    # response_hash = JSON.parse(response_string)
    get_response_hash(x)
    # binding.pry
  end

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

# print get_character_movies_from_api("Luke Skywalker")

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each_with_index do |val, index|
    # binding.pry
    puts "#{index + 1}: Title : #{val["title"]}
Episode: #{val["episode_id"]}
Opening Crawl: #{val["opening_crawl"]}
Director: #{val["director"]}
Producer: #{val["producer"]}
Released Date: #{val["release_date"]}"
  end
end
# print_movies(get_character_movies_from_api("Luke Skywalker"))

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
