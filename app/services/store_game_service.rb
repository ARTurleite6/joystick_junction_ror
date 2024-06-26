class StoreGameService
  Result = Struct.new(:success?, :game, :errors, keyword_init: true)

  def initialize(api_game)
    @api_game = api_game
  end

  def perform
    api_game = if @api_game['cover'].present?
                 @api_game.except('cover').merge({ 'image_url' => @api_game['cover']['url'] })
               else
                 @api_game
               end

    puts api_game.inspect

    Game.upsert(api_game)

    Result.new(success?: true, game: Game.find(api_game['id']))
  rescue ActiveRecord::RecordInvalid => e
    Result.new(success?: false, errors: e.record.errors)
  end
end
