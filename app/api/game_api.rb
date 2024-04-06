# frozen_string_literal: true

require 'uri'
require 'json'
require 'faraday'

class GameApi
  API_ENDPOINT = 'https://api.igdb.com/v4/games'

  def self.find(id)
    db_game = Game.find_by(id: id)
    return db_game unless db_game.nil?

    token = FetchToken.perform

    headers =
      { 'client-id' => Rails.application.credentials.igdb.client_id,
        'authorization' => "Bearer #{token}" }
    params = "fields id, name, total_rating, summary, cover.url; where id = #{id}; limit 1;"

    response = Faraday.post API_ENDPOINT, params, headers
    parsed = JSON.parse response.body
    return nil if parsed.empty?

    StoreGameService.new(parsed[0]).perform
  end

  def self.random(limit: 12)
    response = Faraday.post "#{API_ENDPOINT}/count", '', headers
    count = JSON.parse(response.body)['count']

    random_numbers = []
    while random_numbers.length < limit
      random_number = rand(1..count)
      random_numbers << random_number unless random_numbers.include?(random_number)
    end

    all(random_numbers)
  end

  # it really is only 500
  def self.all(ids)
    db_games = Game.where(id: ids)
    ids -= db_games.map(&:id)

    where = "where id = (#{ids.join(',')});"
    params = "fields id, name, total_rating, summary, cover.url;#{where}"

    response = Faraday.post API_ENDPOINT, params, headers
    response = JSON.parse response.body
    StoreGamesService.new(response).perform
  end

  def self.top_games(limit = 10)
    params = "fields id, name, total_rating, summary, cover.url; limit #{limit}; sort total_rating desc;"
    response = Faraday.post API_ENDPOINT, params, headers

    JSON.parse response.body
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
