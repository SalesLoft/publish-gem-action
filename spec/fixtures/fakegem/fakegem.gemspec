Gem::Specification.new do |spec|
  spec.name          = "fake-gem"
  spec.version       = "13.3.7"
  spec.authors       = ["Ben Olive"]
  spec.email         = ["ben.olive@salesloft.com"]

  spec.summary       = "Totally fake"
  spec.homepage      = "https://github.com/SalesLoft/publish-gem-action"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://gems.example.com/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/SalesLoft/publish-gem-action"

  spec.files         = ["lib/fakegem.rb"]
  spec.require_paths = ["lib"]
end
