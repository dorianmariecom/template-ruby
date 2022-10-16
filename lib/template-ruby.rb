require "parslet"
require "zeitwerk"
require "bigdecimal"
require "active_support"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/object/deep_dup"
require "stringio"
require "timeout"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.ignore("#{__dir__}/template-ruby.rb")
loader.ignore("#{__dir__}/code-ruby.rb")
loader.setup

class Hash
  def multi_fetch(*keys)
    keys.map { |key| [key, fetch(key)] }.to_h
  end
end
