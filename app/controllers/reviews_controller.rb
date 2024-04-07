# frozen_string_literal: true

class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def top
    @reviews = Review.includes(:user).order(like_count: :desc)

    render json: { reviews: @reviews }, status: :ok
  end

  def create
    result = CreateReviewService.new(review_params).perform

    if result.success?
      render json: { message: 'Review created successfully' }, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :game_id, :user_id)
  end
end
