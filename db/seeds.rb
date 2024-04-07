# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)

GameApi.all((1..400).to_a)

Game.all.each do |game|
  user = User.find_or_create_by!(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name,
                                 username: FFaker::Internet.user_name)

  Review.find_or_create_by!(description: FFaker::Lorem.paragraph, rating: rand(1..5), user_id: user.id,
                            like_count: rand(1..100), game:)

  UserWhishlist.find_or_create_by!(user_id: user.id, game_id: game.id)
end
