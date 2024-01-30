class Template
  EMPTY_STRING = ""
  GLOBALS = %i[io context object].freeze
  DEFAULT_TIMEOUT = 0

  def initialize(input, io: ::StringIO.new, timeout: DEFAULT_TIMEOUT, ruby: {})
    @input = input
    @parsed =
      Timeout.timeout(timeout) { ::Template::Parser.parse(@input).to_raw }
    @io = io
    @timeout = timeout || DEFAULT_TIMEOUT
    @ruby =
      Timeout.timeout(timeout) do
        ::Code::Ruby.to_code(ruby || {}).code_to_context
      end
  end

  def self.evaluate(
    input,
    context = "",
    io: ::StringIO.new,
    timeout: DEFAULT_TIMEOUT,
    ruby: {}
  )
    new(input, io:, timeout:, ruby:).evaluate(context)
  end

  def evaluate(context = "")
    Timeout.timeout(timeout) do
      context =
        if context == EMPTY_STRING
          ::Code::Object::Context.new
        else
          ::Code.evaluate(context, timeout:, io:, ruby:).code_to_context
        end

      unless context.is_a?(::Code::Object::Context)
        raise(Error::IncompatibleContext)
      end

      context = context.merge(ruby)

      ::Template::Node::Template.new(parsed).evaluate(context:, io:)

      io.is_a?(::StringIO) ? io.string : nil
    end
  end

  private

  attr_reader :input, :parsed, :timeout, :io, :ruby
end
