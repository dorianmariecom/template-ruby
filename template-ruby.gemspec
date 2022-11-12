require_relative "lib/template/version"

Gem::Specification.new do |s|
  s.name = "template-ruby"
  s.version = ::Template::Version
  s.summary = "A templating programming language"
  s.description =
    'A templating programming language, like "Hello {name}" with {name: "Dorian"} gives "Hello Dorian"'
  s.authors = ["Dorian Marié"]
  s.email = "dorian@dorianmarie.fr"
  s.files = `git ls-files`.split($/)
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.homepage = "https://github.com/dorianmariefr/template-ruby"
  s.license = "MIT"
  s.executables = "template"

  s.add_dependency "template-ruby-parser", "~> 0"
end
