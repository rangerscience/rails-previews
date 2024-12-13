
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_previews/version"

Gem::Specification.new do |spec|
  spec.name          = "rails-previews"
  spec.version       = RailsPreviews::VERSION
  spec.authors       = [ "Nicholas Barone" ]
  spec.email         = [ "nicktbarone@gmail.com" ]

  spec.summary       = %q(A rails engine for previewing views in many forms)
  spec.description   = %q(
    Rails Previews is a Rails engine that allows you to preview the pieces that make up your views,
    specifically: partials, view components, and react-on-rails components
  )
  spec.homepage      = "http://github.com/rangerscience/rails-previews"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = [ "lib" ]

  spec.add_development_dependency "bundler", "~> 2.5"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "debug", "~> 1.6"
  spec.add_development_dependency "rubocop", "~> 1.6"
  spec.add_development_dependency "rubocop-rails-omakase", "~> 1.0"
  spec.add_development_dependency "view_component", "~> 3.14"
  spec.add_development_dependency "react_on_rails", "~> 14.0"

  spec.add_dependency "rails", "~> 7.2"
  spec.add_dependency "slim", "~> 5.2"
end
