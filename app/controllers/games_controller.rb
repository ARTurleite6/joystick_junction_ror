# frozen_string_literal: true

class GamesController < ApplicationController
  def index
    @games = Game.random

    render json: { games: @games }, status: :ok
  end

  def show
    @game = Game.find(params[:id])
    if @game.nil?
      render json: { error: 'Game not found' }, status: :not_found
    else
      @game_reviews = Review.where(game_id: params[:id])
      render json: { game: @game, reviews: @game_reviews }
    end
  end

  def trending
    game_ids = Review.trending_games.map(&:game_id).join(',')
    wrapped_game_ids = "(#{game_ids})"

    @games = Game.all(where: "id = #{wrapped_game_ids}")

    render json: { games: @games }, status: :ok
  end
end
