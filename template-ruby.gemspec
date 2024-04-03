# frozen_string_literal: true

require "English"
require_relative "lib/template/version"

Gem::Specification.new do |s|
  s.name = "template-ruby"
  s.version = ::Template::Version
  s.summary = "A templating programming language"
  s.description =
    'A templating programming language, like "Hello {name}" with {name: "Dorian"} gives "Hello Dorian"'
  s.authors = ["Dorian Marié"]
  s.email = "dorian@dorianmarie.fr"
  s.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.require_paths = ["lib"]
  s.homepage = "https://github.com/dorianmariecom/template-ruby"
  s.license = "MIT"
  s.executables = "template"

  s.add_dependency "code-ruby", "~> 0"
  s.add_dependency "language-ruby", "~> 0"
  s.add_dependency "zeitwerk", "~> 2"

  s.required_ruby_version = ">= 3.3.0"
end
