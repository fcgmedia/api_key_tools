# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_key_tools/version'

Gem::Specification.new do |spec|
  spec.name          = "api_key_tools"
  spec.version       = ApiKeyTools::VERSION
  spec.authors       = ["Samuel O. Obukwelu"]
  spec.email         = ["sam@fcgmedia.com"]
  spec.summary       = %q{A small set of tools to encode and validate data sent to api }
  spec.description   = %q{A tool to protect api data}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "timecop"
end
