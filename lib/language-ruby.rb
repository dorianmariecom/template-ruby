require "bigdecimal"
require "stringio"
require "timeout"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.ignore("#{__dir__}/template-ruby.rb")
loader.ignore("#{__dir__}/code-ruby.rb")
loader.ignore("#{__dir__}/language-ruby.rb")
loader.setup
