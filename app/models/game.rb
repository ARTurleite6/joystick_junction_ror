# frozen_string_literal: true

require 'uri'
require 'json'
require 'faraday'

class Game
  API_ENDPOINT = 'https://api.igdb.com/v4/games'

  def initialize(attributes)
    attributes.each do |attribute_name, attribute_value|
      ##### Method one #####
      # Works just great, but uses something scary like eval
      # self.class.class_eval {attr_accessor attribute_name}
      # self.instance_variable_set("@#{attribute_name}", attribute_value)

      ##### Method two #####
      # Manually creates methods for both getter and setter and then
      # sends a message to the new setter with the attribute_value
      self.class.send(:define_method, "#{attribute_name}=".to_sym) do |value|
        instance_variable_set("@#{attribute_name}", value)
      end

      self.class.send(:define_method, attribute_name.to_sym) do
        instance_variable_get("@#{attribute_name}")
      end

      send("#{attribute_name}=".to_sym, attribute_value)
    end
  end

  def self.find(id)
    token = FetchToken.perform

    headers =
      { 'client-id' => Rails.application.credentials.igdb.client_id,
        'authorization' => "Bearer #{token}" }
    params = "fields id, name, rating, summary; where id = #{id}; limit 1;"

    response = Faraday.post API_ENDPOINT, params, headers
    parsed = JSON.parse response.body
    return nil if parsed.empty?

    Game.new(parsed[0])
  end

  # it really is only 500
  def self.all(where: '')
    where = "where #{where};" unless where.empty?
    token = FetchToken.perform

    headers =
      { 'client-id' => Rails.application.credentials.igdb.client_id,
        'authorization' => "Bearer #{token}" }
    params = "fields id, name, rating, summary;#{where}"

    response = Faraday.post API_ENDPOINT, params, headers
    parsed = JSON.parse response.body
    parsed.map do |game|
      Game.new(game)
    end
  end

  def self.top_games(limit = 10)
    params = "fields id, name, rating, summary; limit #{limit}; sort rating desc;"
    response = Faraday.post API_ENDPOINT, params, headers

    parsed = JSON.parse response.body
    puts parsed.inspect

    parsed.map do |game|
      Game.new(game)
    end
  end

  def self.headers
    token = FetchToken.perform
    {
      'client-id' => Rails.application.credentials.igdb.client_id,
      'authorization' => "Bearer #{token}"
    }
  end
end
