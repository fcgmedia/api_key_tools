# ApiKeyTools

A small set of classes that I use to encode and validate data sent between servers

## Installation

Add this line to your application's Gemfile:

    gem 'api_key_tools'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api_key_tools

## Usage

To encode:
  key_encoder = ApiKeyTools::Encode.new(user_id, secret, time_as_an_integer)
  open_secret = key_encoder.to_s # this is what you want exposed not the secret

To validate:
  validator = ApiKeyTools::Validator.new(key_encoder, open_secret)
  validator.valid?


## Contributing

1. Fork it ( http://github.com/fcgmedia/api_key_tools/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
