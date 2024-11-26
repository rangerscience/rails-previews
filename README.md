# RailsPreviews

A Rails engine to allow previews of many different kinds of Rails view pieces, specifically:

- Partials
- View Components
- React-on-Rails React Components

Cribbed from the internals of the preview engine for View Components, and built to work with the [rails-storybook](https://github.com/rangerscience/rails-storybook) gem.

This gem is *extremely* barebones so far!

## Installation

```ruby
gem 'rails-previews'
```

Then mount the engine where you want it:
```ruby
mount RailsPreviews::Engine => "/previews"
```

## Usage

Previews should be defined in `spec/preview/*.rb` files (and inherit from the helper class), inside a `Previews` module. Each class function becomes an example, and under the hood, it's just passing the hash directly into the bog-standard Rail's controller `render` function, so basic usage is simple:

```ruby
module Previews
  class Example < RailsPreviews::Preview
    def example_1
      { plain: "Hello, World!" }
    end

    def example_2
      { partial: 'your_partial_name',  locals: {  foo: "bar" } }
    end
  end
end
```

To cut down on boiler plate for partials, there's a utility function:

```ruby
module Previews
  class Example < RailsPreviews::Preview
    def example_2
      render_partial 'your_partial_name', {  foo: "bar" }
    end
  end
end
```

If you're using Github's View Components:

```ruby
module Previews
  class Example < RailsPreviews::Preview
    def example_3
      MyViewComponent.new(name: "Foo")
    end
  end
end
```

Lastly, if you're using Shakapacker's React On Rails, this gem provides a handy partial:
```ruby
module Previews
  class Example < RailsPreviews::Preview
    def example_4
      {
        partial: "previews/react_on_rails",
        locals: {
          pack: "application", # This being the name of your React component pack/bundle/thing
          component_name: "MyReactComponent",
          props: {foo: "bar"}
        }
      }
    end
  end
end
```

Or, with a helper to eliminate boilerplate:
```ruby
module Previews
  class Example < RailsPreviews::Preview
    def example_4
      render_react_on_rails "MyReactComponent", foo: "bar"
    end
  end
end
```
(FYI: `pack` is an optional keyword argument, defaulting to `"application"`)

Visit `http://localhost:3000/previews/` (or whever you mounted the engine) to see your examples!


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rangerscience/rails-previews. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RailsPreviews project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rangerscience/rails-previews/blob/master/CODE_OF_CONDUCT.md).
