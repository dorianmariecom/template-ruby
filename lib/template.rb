class Template
  DEFAULT_TIMEOUT = 10

  def initialize(input, io: StringIO.new, timeout: DEFAULT_TIMEOUT, ruby: {})
    @input = input
    @parsed =
      Timeout.timeout(timeout) { ::Template::Parser.parse(@input).to_raw }
    @io = io
    @timeout = timeout || DEFAULT_TIMEOUT
    @ruby = ::Code::Ruby.to_code(ruby || {})
  end

  def self.render(
    input,
    context = "",
    io: StringIO.new,
    timeout: DEFAULT_TIMEOUT,
    ruby: {}
  )
    new(input, io: io, timeout: timeout, ruby: ruby).render(context)
  end

  def render(context = "")
    Timeout.timeout(timeout) do
      if context != ""
        context = ::Code.evaluate(context, timeout: timeout, io: io, ruby: ruby)
      else
        context = ::Code::Object::Dictionnary.new
      end

      if !context.is_a?(::Code::Object::Dictionnary)
        raise ::Code::Template::IncompatibleContext.new(
                "context must be a dictionnary"
              )
      end

      context = context.merge(ruby)

      ::Template::Node::Template.new(parsed).evaluate(context: context, io: io)

      io.is_a?(StringIO) ? io.string : nil
    end
  end

  private

  attr_reader :parsed, :io, :timeout, :ruby
end

require_relative "template/version"
