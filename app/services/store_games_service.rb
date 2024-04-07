class StoreGamesService
  Result = Struct.new(:success?, :games, :errors, keyword_init: true)

  def initialize(api_games)
    @api_games = api_games
  end

  def perform
    @api_games = @api_games.map do |api_game|
      if api_game['cover'].present?
        api_game.except('cover').merge(image_url: api_game['cover']['url'])
      else
        api_game
      end
    end

    @api_games.each do |api_game|
      Game.create!(api_game)
    end
  end
end
