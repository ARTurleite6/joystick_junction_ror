require 'net/http'
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
        instance_variable_set("@" + attribute_name.to_s, value)
      end

      self.class.send(:define_method, attribute_name.to_sym) do
        instance_variable_get("@" + attribute_name.to_s)
      end

      self.send("#{attribute_name}=".to_sym, attribute_value)
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
    return Game.new(parsed[0])
  end

  # it really is only 500
  def self.all
    token = FetchToken.perform

    headers =
      { 'client-id' => Rails.application.credentials.igdb.client_id, 
      'authorization' => "Bearer #{token}" }
    params = "fields id, name, rating, summary; limit 500;"

    response = Faraday.post API_ENDPOINT, params, headers
    parsed = JSON.parse response.body
    return parsed.map do | valor | 
      Game.new(valor)
    end
  end
end
