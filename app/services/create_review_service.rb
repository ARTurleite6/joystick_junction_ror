class CreateReviewService
  Result = Struct.new(:success?, :errors, :review, keyword_init: true)

  def initialize(params)
    @params = params
  end

  def perform
    review = Review.create!(params)

    Result.new(success?: true, review:)
  rescue ActiveRecord::RecordInvalid => e
    Result.new(success?: false, errors: e.record.errors.full_messages)
  end

  private

  attr_reader :params
end