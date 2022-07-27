require "parslet"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.setup

class Template
  def initialize(input)
    @input = input
    @parsed = ::Template::Parser::Template.new.parse(@input)
  end

  def self.render(input, context = "")
    new(input).render(context)
  end

  def render(context = "")
    if context.present?
      context = ::Code.evaluate(context)
    else
      context = ::Code::Object::Dictionnary.new
    end

    ::Template::Node::Template.new(@parsed).evaluate(context).map(&:to_s).join
  end
end
