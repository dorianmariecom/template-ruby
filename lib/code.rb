class Code
  def initialize(input)
    @input = input
    @parsed = ::Code::Parser::Code.new.parse(@input)
  end

  def self.evaluate(input, context = "")
    new(input).evaluate(context)
  end

  def evaluate(context = "")
    if context.present?
      context = ::Code.evaluate(context)
    else
      context = ::Code::Object::Context.new
    end

    ::Code::Node::Code.new(parsed).evaluate(context)
  end

  private

  attr_reader :input, :parsed
end
