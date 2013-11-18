class Order
  def initialize(order_hash)
    @order_hash = order_hash
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
