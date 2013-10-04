require 'uri'

class Order
  def initialize(order_hash)
    @order_hash = order_hash
  end

  def customer_phone
    @order_hash['billing_address']['phone']
  end

  def number
    @order_hash['number']
  end

  def customer_name
    @order_hash['billing_address']['firstname']
  end
end

class TwilioEndpoint < EndpointBase
  set :logging, true

  post '/sms_order' do
    order  = Order.new(@message['payload']['order'])

    client = Twilio::REST::Client.new(@config['twilio.account_sid'], @config['twilio.auth_token'])

    body   = "Hey #{order.customer_name}! Your order #{order.number} has been received."

    client.account.messages.create(
      from:   @config['twilio.phone_from'],
      to:     order.customer_phone,
      body:   body
    )

    process_result 200, { message_id: @message[:message_id] }
  end

  post '/call_order' do
    order  = Order.new(@message['payload']['order'])

    client = Twilio::REST::Client.new(@config['twilio.account_sid'], @config['twilio.auth_token'])

    body   = "Hey #{order.customer_name}! Your order has been received."

    url = 'http://urlecho.appspot.com/echo?status=200&Content-Type=text%2Fxml&body='
    url += "<?xml version='1.0' encoding='UTF-8'?><Response><Say>#{body}</Say></Response>"
    url = URI.escape(url)

    client.account.calls.create(
      from:   @config['twilio.phone_from'],
      to:     order.customer_phone,
      url:    url
    )

    process_result 200, { message_id: @message[:message_id] }
  end
end

