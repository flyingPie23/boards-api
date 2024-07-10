# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "cleaning database..."
  Board.destroy_all
  User.destroy_all

puts "creating users..."
  User.create(email: "user@gmail.com", password: "123456", username: "user")


puts "creating boards..."

  10.times do |i|
    Board.create(title: "Board #{i + 2}", description: "Description #{i + 2}", user_id: User.last.id)
  end

puts "done!"
puts "created #{Board.count} boards made by #{User.count} users."
