require "bigdecimal"
require "stringio"
require "timeout"
require "code-ruby-parser"
require_relative "template"
require_relative "code"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.ignore("#{__dir__}/template-ruby.rb")
loader.ignore("#{__dir__}/code-ruby.rb")
loader.setup
