require 'spec_helper'

describe TwilioEndpoint do

  let(:config) { [{ name: "twilio.account_sid",   value: 'ABC' },
                  { name: "twilio.auth_token",    value: 'ABC' },
                  { name: "twilio.phone_from",    value: twilio_phone_from },
                  { name: 'twilio.address_type',  value: 'billing' }] }

  let(:message) { { message_id: '1234567' } }

  let(:twilio_phone_from) { '+55123' }
  let(:customer_phone) { '+55321' }
  let(:customer_name) { 'Pablo' }
  let(:order_number) { 'RN123456' }

  let(:order) { { number: order_number, billing_address: { firstname: customer_name, phone: customer_phone } } }

  let(:request) { { message: 'order:new',
                    message_id: '1234567',
                    payload: { order: order,  parameters: config } } }

  let(:client) { double('Twilio client').as_null_object }

  def auth
    { 'HTTP_X_AUGURY_TOKEN' => 'x123', 'CONTENT_TYPE' => 'application/json' }
  end

  def app
    TwilioEndpoint
  end


  before do
    Twilio::REST::Client.stub(:new).with('ABC', 'ABC').and_return(client)
  end

  describe '/sms_order' do
    it 'notifiers new order' do
      client.should_receive(:create).with(
        from: twilio_phone_from,
        to: customer_phone,
        body: "Hey #{customer_name}! Your order #{order_number} has been received."
      )

      post '/sms_order', request.to_json, auth

      expect(last_response).to be_ok
      expect(last_response.body).to match /1234567/
    end
  end

  describe '/call_order' do
    it 'notifiers new order' do
      client.should_receive(:create).with(hash_including(
        from: twilio_phone_from,
        to: customer_phone,
      ))

      post '/call_order', request.to_json, auth

      expect(last_response).to be_ok
      expect(last_response.body).to match /1234567/
    end
  end
end

