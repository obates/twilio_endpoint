class Order
  def initialize(config, order_hash)
    @order_hash = order_hash
    @config     = config
  end

  def address
    address_type = @config['twilio.address_type'] || "billing"
    @order_hash["#{address_type}_address"]
  end

  def customer_phone
    address['phone']
  end

  def number
    @order_hash['number']
  end

  def customer_name
    address['firstname']
  end
end
