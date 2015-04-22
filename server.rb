require 'sinatra'
require 'pg'
require 'pry'
require 'json'
require 'net/http'


#def db_connection
#  begin
#    connection = PG.connect(dbname: "pokedex")
#    yield(connection)
#  ensure
#    connection.close
#  end
#end

uri_pokedex = URI("http://pokeapi.co/api/v1/pokedex/1/")

response_pokedex = Net::HTTP.get(uri_pokedex)
pokedex = JSON.parse(response_pokedex)
list_of_pokemon = pokedex["pokemon"]

ordered = {}
list_of_pokemon.each do |row|
id = row["resource_uri"].split("/").last.to_i
  if id < 152
    ordered[row["name"].capitalize] = id
  end
end

ordered_pokemon = ordered.sort_by { |_k, v| v }


get "/" do
  redirect "/pokedex"
end

get "/pokedex" do

  image_url = "http://img.pokemondb.net/sprites/black-white/anim/normal/"

  erb :index, locals: { ordered_pokemon: ordered_pokemon,
                        image_url: image_url
                      }
end

get "/pokedex/:id" do |id|

  uri_description = URI("http://pokeapi.co/api/v1/description/#{id}/")
  response_description = Net::HTTP.get(uri_description)
  description = JSON.parse(response_description)

  description_id = description["pokemon"]["resource_uri"].split("/").last.to_i

  uri_pokemon = URI("http://pokeapi.co/api/v1/pokemon/#{id}/")
  response_pokemon = Net::HTTP.get(uri_pokemon)
  pokemon = JSON.parse(response_pokemon)
  evolutions = pokemon["evolutions"]
  types = pokemon["types"]
  moves = pokemon["moves"]
  id = pokemon["pkdx_id"]
  #binding.pry

  image = "http://img.pokemondb.net/sprites/black-white/anim/normal/"

  name = ordered_pokemon.fetch(id.to_i - 1).first
  evolved_name = ordered_pokemon.fetch(id.to_i).first

  erb :id, locals: { name: name,
                     evolved_name: evolved_name,
                     id: id,
                     image: image,
                     pokemon: pokemon,
                     evolutions: evolutions,
                     types: types,
                     moves: moves
                     }
end
