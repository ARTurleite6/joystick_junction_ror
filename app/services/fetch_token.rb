require 'net/http'

class FetchToken
  def self.perform
    url = URI.parse('https://id.twitch.tv/oauth2/token')
    request = Net::HTTP::Post.new(url.path)
    request.set_form_data({
                            'client_id' => Rails.application.credentials.igdb.client_id,
                            'client_secret' => Rails.application.credentials.igdb.token,
                            'grant_type' => 'client_credentials'
                          })
    response = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
      http.request(request)
    end
    # Handle the response here
    if response.code == '200'
      # Successful request
      token = JSON.parse(response.body)['access_token']

    else
      # Error handling
      puts "Request failed with status code #{response.code}"
    end
  end
end

