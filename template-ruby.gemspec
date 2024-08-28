# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "template-ruby"
  s.version = File.read("VERSION").strip
  s.summary = "templating language"
  s.description = s.summary
  s.authors = ["Dorian Marié"]
  s.email = "dorian@dorianmarie.fr"
  s.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.require_paths = ["lib"]
  s.homepage = "https://github.com/dorianmariecom/template-ruby"
  s.license = "MIT"
  s.executables = "template"
  s.add_dependency "code-ruby"
  s.add_dependency "dorian-arguments"
  s.add_dependency "language-ruby"
  s.add_dependency "zeitwerk"
  s.metadata["rubygems_mfa_required"] = "true"
  s.required_ruby_version = "3.3.4"
end
