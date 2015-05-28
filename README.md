# Fastlane::Actions::Emlauncher

A fastlane action for [KLab/emlauncher](https://github.com/KLab/emlauncher).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fastlane-actions-emlauncher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fastlane-actions-emlauncher

## Usage

1. add lane

```ruby
require 'fastlane/actions/emlauncher'

lane :emlauncher do
  ipa
  emlauncher
end
```

2. set environment variables

```bash
FL_EMLAUNCHER_API_URL=...
FL_EMLAUNCHER_API_TOKEN=...
```

3. run fastlane actions

```bash
$ fastlane emlauncher
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fastlane-actions-emlauncher/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
