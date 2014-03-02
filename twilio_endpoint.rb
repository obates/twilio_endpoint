require 'uri'
Dir['./lib/**/*.rb'].each &method(:require)


class TwilioEndpoint < EndpointBase
  set :logging, true

  post '/sms_order' do
    order  = Order.new(@config, @message['payload']['order'])
    client = Twilio::REST::Client.new(@config['twilio.account_sid'], @config['twilio.auth_token'])

    body   = "Hey #{order.customer_name}! Your order #{order.number} has been received."
    
    phone = "+441183247013"

    message = Message.new(@config, body, phone)
    message.deliver


    process_result 200, { message_id: @message[:message_id],
                          notifications: [{ level: 'info', subject: "SMS confirmation sent to #{order.customer_phone}", description: body }] }
  end

  post '/sms_ship' do
    shipment = @message['payload']['shipment']['number']
    order    = @message['payload']['shipment']['order_number']
    name     = @message['payload']['shipment']['shipping_address']['firstname']

    client = Twilio::REST::Client.new(@config['twilio.account_sid'], @config['twilio.auth_token'])

    body   = "Hey #{name}! Your shipment \##{shipment} for order \##{order} has shipped."
    
    phone = "+441183247013"

    message = Message.new(@config, body, phone)
    message.deliver


    process_result 200, { message_id: @message[:message_id],
                          notifications: [{ level: 'info', subject: "SMS confirmation sent to #{phone}", description: body }] }
  end

  post '/sms_cancel' do
    order  = Order.new(@config, @message['payload']['order'])

    client = Twilio::REST::Client.new(@config['twilio.account_sid'], @config['twilio.auth_token'])

    body   = "Hey #{order.customer_name}! Your order #{order.number} has been canceled."

    phone = "+441183247013"

    message = Message.new(@config, body, phone)
    message.deliver


    process_result 200, { message_id: @message[:message_id],
                          notifications: [{ level: 'info', subject: "SMS confirmation sent to #{order.customer_phone}", description: body }] }
  end
end

