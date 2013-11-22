ENDPOINT_KEY = ENV['ENDPOINT_KEY'] = '123'

module Controllers
  def auth
    { 'HTTP_X_AUGURY_TOKEN' => ENDPOINT_KEY, 'CONTENT_TYPE' => 'application/json' }
  end

  def json_response
    @json_response ||= JSON.parse(last_response.body)
  end

  def app
    described_class
  end
end

RSpec.configure do |config|
  config.include Controllers
end

