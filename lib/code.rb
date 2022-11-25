class Code
  EMPTY_STRING = ""
  GLOBALS = %i[io context object]
  DEFAULT_TIMEOUT = Template::DEFAULT_TIMEOUT

  def initialize(input, io: StringIO.new, timeout: DEFAULT_TIMEOUT, ruby: {})
    @input = input
    @parsed = Timeout.timeout(timeout) { ::Code::Parser.parse(@input).to_raw }
    @io = io
    @timeout = timeout || DEFAULT_TIMEOUT
    @ruby = ::Code::Ruby.to_code(ruby || {})
  end

  def self.evaluate(
    input,
    context = "",
    io: StringIO.new,
    timeout: DEFAULT_TIMEOUT,
    ruby: {}
  )
    new(input, io: io, timeout: timeout, ruby: ruby).evaluate(context)
  end

  def evaluate(context = "")
    Timeout.timeout(timeout) do
      if context != EMPTY_STRING
        context = ::Code.evaluate(context, timeout: timeout, io: io, ruby: ruby)
      else
        context = ::Code::Object::Dictionnary.new
      end

      if !context.is_a?(::Code::Object::Dictionnary)
        raise ::Code::Error::IncompatibleContext.new(
                "context must be a dictionnary"
              )
      end

      context = context.merge(ruby)

      ::Code::Node::Code.new(parsed).evaluate(context: context, io: io)
    end
  end

  private

  attr_reader :input, :parsed, :timeout, :io, :ruby
end
