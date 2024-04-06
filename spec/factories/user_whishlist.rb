# frozen_string_literal: true

FactoryBot.define do
  factory :user_whishlist do
    user
    game_id { rand(1..10) }
  end
end
