class Code
  DEFAULT_TIMEOUT = Template::DEFAULT_TIMEOUT

  def initialize(input, io: $stdout, timeout: DEFAULT_TIMEOUT)
    @input = input
    @parsed = Timeout.timeout(timeout) { ::Code::Parser::Code.new.parse(@input) }
    @io = io
    @timeout = timeout || DEFAULT_TIMEOUT
  end

  def self.evaluate(input, context = "", io: $stdout, timeout: DEFAULT_TIMEOUT)
    new(input, io: io, timeout: timeout).evaluate(context)
  end

  def evaluate(context = "")
    Timeout.timeout(timeout) do
      if context.present?
        context = ::Code.evaluate(context, timeout: timeout)
      else
        context = ::Code::Object::Dictionnary.new
      end

      ::Code::Node::Code.new(parsed).evaluate(context: context, io: io)
    end
  end

  private

  attr_reader :input, :parsed, :timeout, :io
end
