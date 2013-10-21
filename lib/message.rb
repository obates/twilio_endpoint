class Message
  def initialize(config, message_text, phone_number)
    @client = Twilio::REST::Client.new(config['twilio.account_sid'], config['twilio.auth_token'])
    @config = config
    @message_text = message_text
    @phone_number = phone_number
  end

  def deliver
    @client.account.messages.create(
      from:   @config['twilio.phone_from'],
      to:     @phone_number,
      body:   @message_text
    )
  end
end
