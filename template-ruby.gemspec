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
  s.add_dependency "code-ruby", ">= 5.0.10", "< 6"
  s.add_dependency "dorian-arguments", ">= 2.0.1", "< 3"
  s.add_dependency "language-ruby", ">= 2.0.2", "< 3"
  s.add_dependency "zeitwerk", ">= 2.8.3", "< 3"
  s.metadata["rubygems_mfa_required"] = "true"
  s.required_ruby_version = ">= 4.0"
end
