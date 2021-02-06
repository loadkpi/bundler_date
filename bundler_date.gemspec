# frozen_string_literal: true

require_relative "lib/bundler_date/version"

Gem::Specification.new do |spec|
  spec.name          = "bundler_date"
  spec.version       = BundlerDate::VERSION
  spec.authors       = ["Pavel Kozlov"]
  spec.email         = ["loadkpi@gmail.com"]

  spec.summary       = "Bunlder plugin to show the release dates of gems."
  spec.description   = "Bunlder plugin to show the release dates of gems."
  spec.homepage      = "https://github.com/loadkpi/bundler_date."
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/loadkpi/bundler_date."
  spec.metadata["changelog_uri"] = "https://github.com/loadkpi/bundler_date/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 2.0"
  spec.add_dependency "gems"
  spec.add_dependency "terminal-table"

  spec.add_development_dependency "rake",    "~> 13.0"
  spec.add_development_dependency "rspec",   "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.7"
end
