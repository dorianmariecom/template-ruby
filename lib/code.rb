class Code
  def initialize(input, io: $stdout, timeout: 10)
    @input = input
    @parsed = Timeout::timeout(timeout) do
      ::Code::Parser::Code.new.parse(@input)
    end
    @io = io
    @timeout = timeout
  end

  def self.evaluate(input, context = "", io: $stdout, timeout: 10)
    new(input, io: io, timeout: timeout).evaluate(context)
  end

  def evaluate(context = "")
    Timeout::timeout(@timeout) do
      if context.present?
        context = ::Code.evaluate(context, timeout: @timeout)
      else
        context = ::Code::Object::Dictionnary.new
      end

      ::Code::Node::Code.new(parsed).evaluate(context: context, io: @io)
    end
  end

  private

  attr_reader :input, :parsed
end
