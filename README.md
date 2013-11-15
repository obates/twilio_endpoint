# Twillio Integration for Spree Commerce Hub

SMS customers every time an order is received or a shipment goes out.

## Usage

You will need a Twilio account. Trial accounts are pretty easy and quick to
setup up. Visit https://www.twilio.com/ for more info.

Once you have your account grab your *SID* and *Auth token*, they should be right
on the dashboard page. Twilio will also provide a phone number. You'll have to
enter that as well on the integration form. Plus choose whether you want to
pick the customer number from the billing or shipping address.

And you're done! For every new order polled a sms will be sent to the user
number provdided on the address.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
