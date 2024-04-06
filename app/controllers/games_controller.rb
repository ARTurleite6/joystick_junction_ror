# frozen_string_literal: true

class GamesController < ApplicationController
  def index
    @games = GameApi.random

    render json: { games: @games }, status: :ok
  end

  def show
    result = GameApi.find(params[:id])

    if result.success?
      @game = result.game

      render json: { game: @game }, status: :ok
    else
      render json: { error: result.errors }, status: :not_found
    end
  end

  def trending
    game_ids = Review.trending_games.includes(:game).map(&:id)

    @games = GameApi.all(game_ids)

    render json: { games: @games }, status: :ok
  end
end
