class Game
    attr_reader :id
    attr_reader :name

    def self.find(id)
        require 'net/http'
        require 'uri'
        require 'json'

        url = URI.parse('https://api.igdb.com/v4/games')
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        token = FetchToken.perform

        uri = URI('https://api.igdb.com/v4/games')
        token = FetchToken.perform
        req = Net::HTTP::Post.new(uri)
        req['Client-ID'] = Rails.application.credentials.igdb.client_id
        req['Authorization'] = "Bearer #{token}"
        req.body = "fields id, name; \\ where id = #{id};"

        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http|
        http.request(req)
        }

        JSON.parse(res.body)
    end

    # it really is only 500
    def self.all()
        require 'net/http'
        require 'uri'
        require 'json'

        url = URI.parse('https://api.igdb.com/v4/games')
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        token = FetchToken.perform

        uri = URI('https://api.igdb.com/v4/games')
        token = FetchToken.perform
        req = Net::HTTP::Post.new(uri)
        req['Client-ID'] = Rails.application.credentials.igdb.client_id
        req['Authorization'] = "Bearer #{token}"
        req.body = "fields id, name; \\ limit 500;"

        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http|
        http.request(req)
        }

        JSON.parse(res.body)
    end

end