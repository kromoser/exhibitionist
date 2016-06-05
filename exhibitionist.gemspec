# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exhibitionist/version'

Gem::Specification.new do |spec|
  spec.name          = "exhibitionist"
  spec.version       = Exhibitionist::VERSION
  spec.authors       = ["kromoser"]
  spec.email         = ["kevin@kevinromoser.com"]

  spec.summary       = %q{Current art exhibitions in NYC}
  spec.description   = %q{A list of some of the current show in NYC, organized by closing date, so you never miss that must-see show.}
  spec.homepage      = "https://github.com/kromoser/exhibitionist"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  #spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables   = ["exhibitionist"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiri"

  
end
