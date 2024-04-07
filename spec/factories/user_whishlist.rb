# frozen_string_literal: true

FactoryBot.define do
  factory :user_whishlist do
    user
    game
  end
end
