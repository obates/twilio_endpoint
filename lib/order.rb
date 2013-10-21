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
