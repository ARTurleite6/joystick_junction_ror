# frozen_string_literal: true

class GamesController < ApplicationController
  def index
    @games = GameApi.random

    render json: { games: @games }, status: :ok
  end

  def search
    result = GameApi.search(params[:name])

    if result.success?
      render json: { game: result.game }, status: :ok
    else
      render json: { errors: result.errors }, status: :not_found
    end
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
    game_ids = Review.trending_games.includes(:game).map(&:game_id)

    @games = GameApi.all(game_ids)

    render json: { games: @games }, status: :ok
  end

  def top
    @games = GameApi.top_games

    render json: { games: @games }, status: :ok
  end
end
