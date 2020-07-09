require 'sinatra'
require 'sinatra/activerecord'
require 'discordrb'
require 'discordrb/webhooks'
require 'dotenv/load'
require 'pry-byebug'

require_relative 'models/art_piece'
require_relative 'models/announcement'
require_relative 'models/user'
require_relative 'models/reaction'
require_relative 'models/handshake'
require_relative 'controllers/bot_controller'

class App < Sinatra::Base
  bot = Discordrb::Commands::CommandBot.new token: ENV['BOT_TOKEN'], prefix: ["i!", "I!"], help_command: false

  controller = BotController.new(bot)

  # BOT USER COMMANDS

  bot.command :thank do |event|
    controller.thank_command(event)
  end

  bot.command :thanks do |event|
    controller.thank_command(event)
  end

  bot.run

end

