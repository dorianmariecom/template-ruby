require "parslet"
require "zeitwerk"
require "bigdecimal"
require "active_support"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/object/deep_dup"
require "stringio"
require "timeout"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.ignore(File.expand_path("lib/template-ruby.rb"))
loader.ignore(File.expand_path("lib/code-ruby.rb"))
loader.setup
