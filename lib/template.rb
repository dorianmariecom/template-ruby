class Template
  DEFAULT_TIMEOUT = 10

  def initialize(input, io: StringIO.new, timeout: DEFAULT_TIMEOUT, ruby: {})
    @input = input
    @parsed =
      Timeout.timeout(timeout) do
        ::Template::Parser::Template.new.parse(@input)
      end
    @io = io
    @timeout = timeout || DEFAULT_TIMEOUT
    @ruby = ::Code::Ruby.convert(ruby || {})
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

      ::Template::Node::Template.new(parsed).evaluate(
        context: context,
        io: io,
        ruby: ruby
      )

      io.is_a?(StringIO) ? io.string : nil
    end
  end

  private

  attr_reader :parsed, :io, :timeout, :ruby
end

require_relative "template/version"
