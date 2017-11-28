lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vidyo/version"

Gem::Specification.new do |spec|
  spec.name          = "vidyo"
  spec.version       = Vidyo::VERSION
  spec.authors       = ["Omar Bohsali"]
  spec.email         = ["me@omarish.com"]

  spec.summary       = %q{Create vidyo.io access tokens.}
  spec.homepage      = "https://github.com/omarish/vidyo"
  spec.license       = "MIT"
  spec.metadata = {
    "documentation_uri" => "https://github.com/omarish/vidyo",
    "homepage_uri"      => "https://github.com/omarish/vidyo",
    "source_code_uri"   => "https://github.com/omarish/vidyo"
  }
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'rspec-expectations', '~> 3.7', '>= 3.7.0'
  spec.add_development_dependency "timecop", "~> 0.9.1"
end