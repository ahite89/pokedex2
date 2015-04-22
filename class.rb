require 'pokegem'
require 'json'

class Pokemon

  attr_reader :id, :name, :image_url

  def initialize(id)
    @id = id
    if id.to_i <= 151
      info = JSON.parse(Pokegem.get 'pokemon', @id)
      @name = info["name"]
      @image_url = "http://img.pokemondb.net/sprites/black-white/anim/normal/#{@name.downcase}.gif"
    else
      @name = "MissingNo"
      @image_url = "/img/missingno.png"
    end
  end

end

151.times do |num|
  pokemon = JSON.parse(Pokegem.get 'pokemon', num)
  parsed_pokemon = pokemon.parse # return an array of the exact data for the pokemon to be inserted into DB
  # one specific array of the exact data

  db_connection do |conn|
    sql = "insert into pokemon (values) $1, $2"
    conn.exec_params(sql, parsed_pokemon)
  end
end
