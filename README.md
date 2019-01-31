# OmniAuth Zoho

Zoho OAuth2 Strategy for OmniAuth 1.0 to access Zoho services.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-zoho', git: 'https://github.com/oozou/omniauth-zoho.git'
```

And then execute:

    $ bundle

## Usage

This is simply a rack midddleware based on [Omniauth](https://github.com/omniauth/omniauth).

Add this in a initializer such as `initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :zoho, ENV['ZOHO_CLIENT_ID'], ENV['ZOHO_CLIENT_SECRET'], scope: 'Aaaserver.profile.read'
end
```

You will need to at least add the `Aaaserver.profile.read` scope to authenticate and get the user's Email and UID.

### Auth Hash

The auth hash will have the following info:

```ruby
{
  "provider" => "zoho",
  "uid" => "123446",
  "info" => {
    "email" => "jane@example.com",
    "first_name" => "Jane",
    "last_name" => "Doe",
    "display_name" => "JaneDoe"
  },
  "credentials" => {
    "token" => "1000.this_is_the_token",
    "expires_at" => 12345678,
    "expires" => true
  },
  "extra" => {
    "raw_info" => {
      "First_Name" => "Jane",
      "Email" => "jane@example.com",
      "Last_Name" => "Doe",
      "Display_Name" => "JaneDoe",
      "ZUID" => 123446
    }
  }
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/omniauth-zoho. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Omniauth::Zoho project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/omniauth-zoho/blob/master/CODE_OF_CONDUCT.md).
