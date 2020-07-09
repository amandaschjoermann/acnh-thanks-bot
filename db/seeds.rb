Dir[File.join(__dir__, '../models', '*.rb')].each { |file| require_relative file }

puts "Prepare for the cleanse!"

Handshake.destroy_all
Reaction.destroy_all
ArtPiece.destroy_all
Announcement.destroy_all
User.destroy_all

puts "All clean now!"
