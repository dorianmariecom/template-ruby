require "stringio"
require "timeout"
require "zeitwerk"
require "code-ruby"
require "template-ruby"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.ignore("#{__dir__}/template-ruby.rb")
loader.setup
