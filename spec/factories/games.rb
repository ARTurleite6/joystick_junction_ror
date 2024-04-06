# == Schema Information
#
# Table name: games
#
#  id           :integer          not null
#  image_url    :string
#  name         :string           not null
#  summary      :text
#  total_rating :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_games_on_id  (id) UNIQUE
#
FactoryBot.define do
  factory :game do
    id { FFaker::Random.rand(1..100) }
    name { FFaker::Name.name }
    total_rating { '9.99' }
    image_url { FFaker::Image.url }
    summary { FFaker::Lorem.paragraph }
  end
end
