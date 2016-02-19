# ⚓ Anchors ⚓

[![Build Status](https://travis-ci.org/bradgessler/anchors.svg?branch=master)](https://travis-ci.org/bradgessler/anchors)

This gem will add anchors to all of your websites h1-h6 headers. Its useful for static website generators, like Middleman. It turns this:

```html
<body>
  <h1>How are you?</h1>
  <h2>I am fine<img src='hi.gif'/></h2>
  <h3>How are you?</h3>
</body>
```

into this:

```html
<body>
  <h1 id="how_are_you"><a href="#how_are_you">How are you?</a></h1>
  <h2 id="i_am_fine"><a href="#i_am_fine">I am fine<img src="hi.gif"></a></h2>
  <h3 id="how_are_you_2"><a href="#how_are_you_2">How are you?</a></h3>
</body>
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'anchors'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install anchors

## Usage

Just use the middleware from your rack config.ru file or Middleman config.rb file as follows:

```ruby
require "anchors"
use Anchors::Middleware
```

and the `body` will automatically have anchors applied to all of the h1-h6 tags.

You can even customize it a bit:

```ruby
require "anchors"
use Anchors::Middleware,
  css: "section.anchorize", # CSS headers are applied to. Defaults to 'body'
  seperator: "-",           # Change the seperator in the header. Defaults to '_'
  link: false               # Don't convert the headers into links to their own anchors. Defaults to 'true'.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bradgessler/anchors.

