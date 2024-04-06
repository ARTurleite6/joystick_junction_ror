# frozen_string_literal: true

class FollowUserService
  Result = Struct.new(:success?, :errors, keyword_init: true)

  def initialize(params)
    @params = params
  end

  def perform
    UserFriend.create!(params)

    Result.new(success?: true)
  rescue ActiveRecord::RecordInvalid => e
    Result.new(success?: false, errors: e.record.errors.full_messages)
  end

  private

  attr_reader :params
end
