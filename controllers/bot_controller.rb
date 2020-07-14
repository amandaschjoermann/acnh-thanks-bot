require 'pry-byebug'

BOT_IDS = [
  719718875767504896,
  730794674217943071,
  707469831280263168,
  727350516023033888,
  235148962103951360,
  728919522081243157
]

class BotController
  def initialize(bot)
    @bot = bot
  end

  def thank_command(event)
    channel = @bot.channel(ENV['CHANNEL_ID'])



    event.message.delete
    thanker = set_user(event.user)

    return @bot.send_message(ENV['CHANNEL_ID'], "", nil, { description: "#{thanker.mention} please mention the user you would like to thank! ☝️", color: 0xc3e400 } ) unless event.message.mentions.first
    return @bot.send_message(ENV['CHANNEL_ID'], "", nil, { description: "That's very kind of you #{thanker.mention}, but you can't thank the bots! 😳", color: 0xc3e400 } ) if BOT_IDS.include?(event.message.mentions.first.id)

    thankee = set_user(event.message.mentions.first)
    thankee_nickname = channel.server.member(thankee.discord_id).nickname

    if thankee == thanker
      @bot.send_message(ENV['CHANNEL_ID'], "", nil, { description: "Lol. You're sneaky #{thanker.mention}! You can't thank yourself! 🤪", color: 0xc3e400 } )
      return nil
    elsif event.message.mentions.first

      if event.message.content.split(">").second.nil?
        content = ""
      else
        content = event.message.content.split(">", 2).second.strip.capitalize
      end

      handshake = Handshake.create!(thankee: thankee, thanker: thanker)
      @bot.send_message(ENV['CHANNEL_ID'], "#{thanker.mention} has thanked #{thankee.mention}! " + content)
      @bot.send_message(ENV['CHANNEL_ID'], "", nil, { description: handshake.generate_message(thankee_nickname), color: 0xc3e400 } )
      return nil
    else
      return "Something went wrong!"
    end
  end

  private

  def set_user(event_user)
    user = User.find_by_discord_id(event_user.id)
    user ? user : User.create(discord_id: event_user.id, discord_name: event_user.username)
  end
end

