class UsersController < ApplicationController
  def follow
    result = FollowUserService.new(follow_params).perform

    if result.success?
      render json: { message: 'User followed successfully' }, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def follow_params
    params.permit(:user_id, :friend_id)
  end
end
