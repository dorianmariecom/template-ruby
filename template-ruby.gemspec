Gem::Specification.new do |s|
  s.name = "template-ruby"
  s.version = "0.1.0"
  s.summary = "A templating programming language"
  s.description =
    'Like "Hello {name}" with {name: "Dorian"} gives "Hello Dorian"'
  s.authors = ["Dorian Marié"]
  s.email = "dorian@dorianmarie.fr"
  s.files = `git ls-files`.split($/)
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.homepage = "https://github.com/dorianmariefr/template-ruby"
  s.license = "MIT"

  s.add_dependency "activesupport", "~> 7"
  s.add_dependency "parslet", "~> 2"
  s.add_dependency "zeitwerk", "~> 2.6"

  s.add_development_dependency "prettier", "~> 3"
  s.add_development_dependency "rspec", "~> 3"
end
