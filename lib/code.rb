class Code
  def initialize(input, io: $stdout)
    @input = input
    @parsed = ::Code::Parser::Code.new.parse(@input)
    @io = io
  end

  def self.evaluate(input, context = "", io: $stdout)
    new(input, io: io).evaluate(context)
  end

  def evaluate(context = "")
    if context.present?
      context = ::Code.evaluate(context)
    else
      context = ::Code::Object::Dictionnary.new
    end

    ::Code::Node::Code.new(parsed).evaluate(context: context, io: @io)
  end

  private

  attr_reader :input, :parsed
end
