# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'affiliate_hub/version'

Gem::Specification.new do |spec|
  spec.name          = "affiliate_hub"
  spec.version       = AffiliateHub::VERSION
  spec.authors       = ["Felipe Jordão A.P Mattosinho"]
  spec.email         = ["felipe.japm@gmail.com"]

  spec.summary       = %q{ a short summary, because Rubygems requires one.}
  spec.description   = %q{}
  spec.homepage      = "http://github.com/codextremist/affiliate_hub"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  
  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "nokogiri"

end
