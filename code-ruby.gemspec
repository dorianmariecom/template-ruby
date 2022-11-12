require_relative "lib/template/version"

Gem::Specification.new do |s|
  s.name = "code-ruby"
  s.version = ::Template::Version
  s.summary = "A programming language"
  s.description = 'A programming language, like Code.evaluate("1 + 1") # => 2'
  s.authors = ["Dorian Marié"]
  s.email = "dorian@dorianmarie.fr"
  s.files = `git ls-files`.split($/)
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.homepage = "https://github.com/dorianmariefr/template-ruby"
  s.license = "MIT"

  s.add_dependency "code-ruby-parser", "~> 0"
end
