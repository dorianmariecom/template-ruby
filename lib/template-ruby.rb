require "parslet"
require "zeitwerk"
require "bigdecimal"
require "active_support"
require "active_support/core_ext/object/blank"
require "stringio"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.ignore(__FILE__)
loader.setup
