FactoryBot.define do
  factory :review do
    description { FFaker::Lorem.paragraph }
    rating { rand(1..5) }
    like_count { rand(1..10) }
    game_id { rand(1..10) }
    user
  end
end
