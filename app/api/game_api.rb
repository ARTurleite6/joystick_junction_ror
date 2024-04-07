# frozen_string_literal: true

require 'uri'
require 'json'
require 'faraday'

class GameApi
  API_ENDPOINT = 'https://api.igdb.com/v4/games'
  PARAMS = 'fields id, name, total_rating, summary, cover.url;'

  def self.find(id)
    db_game = Game.find_by(id:)
    return StoreGameService::Result.new(success?: true, game: db_game) unless db_game.nil?

    params = "#{PARAMS} where id = #{id}; limit 1;"

    response = Faraday.post API_ENDPOINT, params, headers
    parsed = JSON.parse response.body
    return nil if parsed.empty?

    StoreGameService.new(parsed[0]).perform
  end

  def self.search(name)
    game = Game.find_by(name:)

    return game unless game.nil?

    response = Faraday.post API_ENDPOINT, "#{PARAMS} search \"#{name}\"; limit 1;",
                            headers

    response_json = JSON.parse(response.body)

    return nil if response_json.empty?

    StoreGameService.new(response_json[0]).perform
  end

  def self.random(limit: 12) # Temos de verificar aqui se os ids que são geradas são de jogos sem cover, beca custoso
    response = Faraday.post "#{API_ENDPOINT}/count", '', headers
    count = JSON.parse(response.body)['count']

    random_numbers = []
    while random_numbers.length < limit
      random_number = rand(1..count)
      # game = GameApi.find(random_number).game
      # while game['image_url'].nil? do   # timeouts
      #   random_number = rand(1..count)
      #   game = GameApi.find(random_number).game 
      # end
      random_numbers << random_number unless random_numbers.include?(random_number)
    end

    all(random_numbers)
  end

  # it really is only 500
  def self.all(ids)
    return [] if ids.empty?

    db_games = Game.where(id: ids)
    ids -= db_games.map(&:id)

    return db_games if ids.empty?

    where = "where id = (#{ids.join(',')}) & cover != n & total_rating =! n;" # filtra dos 12 para ir só os que têm cover e total_ratings
    params = "#{PARAMS}#{where}"
    response = Faraday.post API_ENDPOINT, params, headers
    response = JSON.parse response.body
    StoreGamesService.new(response).perform
  end

  def self.top_games(limit = 10)
    params = "#{PARAMS} limit #{limit}; sort total_rating desc;"
    response = Faraday.post API_ENDPOINT, params, headers

    response = JSON.parse response.body
    StoreGamesService.new(response).perform
  end

  class << self
    private

    def headers
      token = FetchToken.perform
      {
        'client-id' => Rails.application.credentials.igdb.client_id,
        'authorization' => "Bearer #{token}"
      }
    end
  end
end
