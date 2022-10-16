class Code
  GLOBALS = [:io, :context, :object, :ruby]
  DEFAULT_TIMEOUT = Template::DEFAULT_TIMEOUT

  def initialize(input, io: $stdout, timeout: DEFAULT_TIMEOUT, ruby: {})
    @input = input
    @parsed =
      Timeout.timeout(timeout) { ::Code::Parser::Code.new.parse(@input) }
    @io = io
    @timeout = timeout || DEFAULT_TIMEOUT
    @ruby = ::Code::Ruby.convert(ruby || {})
  end

  def self.evaluate(input, context = "", io: $stdout, timeout: DEFAULT_TIMEOUT, ruby: {})
    new(input, io: io, timeout: timeout, ruby: ruby).evaluate(context)
  end

  def evaluate(context = "")
    Timeout.timeout(timeout) do
      if context.present?
        context = ::Code.evaluate(
          context,
          timeout: timeout,
          io: io,
          ruby: ruby
        )
      else
        context = ::Code::Object::Dictionnary.new
      end

      ::Code::Node::Code.new(parsed).evaluate(context: context, io: io, ruby: ruby)
    end
  end

  private

  attr_reader :input, :parsed, :timeout, :io, :ruby
end
