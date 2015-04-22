require 'sinatra'
require 'pg'
require 'pry'
require 'json'
require 'net/http'

class Pokemon

  attr_reader :id, :name, :image_url

  def initialize
    uri_dex = URI("http://pokeapi.co/api/v1/pokedex/1/")
    response_dex = Net::HTTP.get(uri_dex)
    @pokedex = JSON.parse(response_dex)
    @list_of_pokemon = pokedex["pokemon"]


    #@name = info["name"]
    #@image_url = "http://img.pokemondb.net/sprites/black-white/anim/normal/#{@name.downcase}.gif"

  end

end

get "/pokedex" do

  erb :index, locals: { list_of_pokemon: list_of_pokemon }

end
