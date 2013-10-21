require 'uri'
class TwilioEndpoint < EndpointBase
  set :logging, true

  post '/sms_order' do
    order  = Order.new(@message['payload']['order'])

    client = Twilio::REST::Client.new(@config['twilio.account_sid'], @config['twilio.auth_token'])

    body   = "Hey #{order.customer_name}! Your order #{order.number} has been received."
    
    message = Message.new(@config, body, order.customer_phone)
    message.deliver

    process_result 200, { message_id: @message[:message_id] }
  end

  post '/call_order' do
    order  = Order.new(@message['payload']['order'])

    client = Twilio::REST::Client.new(@config['twilio.account_sid'], @config['twilio.auth_token'])

    body   = "Hey #{order.customer_name}! Your order #{order.number} has been received."
    
    message = Message.new(@config, body, order.customer_phone)
    message.deliver


    process_result 200, { message_id: @message[:message_id] }
  end


end

