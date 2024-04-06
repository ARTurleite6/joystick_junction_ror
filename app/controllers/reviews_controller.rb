class ReviewsController < ApplicationController
  def index
    @reviews = Review.where(user_id: params[:user_id])
  end

  def top
    @reviews = Review.includes(:user).order(
      'like_count * 0.70 + (SELECT COUNT(*) FROM user_friends WHERE user_friends.friend_id = reviews.user_id) * 0.30', :desc
    )
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
