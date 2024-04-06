require 'net/http'
require 'uri'
require 'json'

class Game
  attr_reader :id, :name

  def self.find(id)
    uri = URI('https://api.igdb.com/v4/games')
    token = FetchToken.perform
    req = Net::HTTP::Post.new(uri)
    req['Client-ID'] = Rails.application.credentials.igdb.client_id
    req['Authorization'] = "Bearer #{token}"
    req.body = "fields id, name; \\ where id = #{id};"

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(req)
    end

    JSON.parse(res.body)
  end

  # it really is only 500
  def self.all
    uri = URI('https://api.igdb.com/v4/games')
    token = FetchToken.perform
    req = Net::HTTP::Post.new(uri)
    req['Client-ID'] = Rails.application.credentials.igdb.client_id
    req['Authorization'] = "Bearer #{token}"
    req.body = 'fields id, name; \\ limit 500;'

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(req)
    end

    JSON.parse(res.body)
  end
end
