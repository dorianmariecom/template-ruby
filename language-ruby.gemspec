require_relative "lib/template/version"

Gem::Specification.new do |s|
  s.name = "language-ruby"
  s.version = ::Template::Version
  s.summary = "A Parsing Expression Grammar (PEG) for making parsers"
  s.description = s.summary
  s.authors = ["Dorian Marié"]
  s.email = "dorian@dorianmarie.fr"
  s.files = `git ls-files`.split($/)
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.homepage = "https://github.com/dorianmariefr/template-ruby"
  s.license = "MIT"

  s.add_dependency "zeitwerk", "~> 2"
end
