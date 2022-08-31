class Template
  VERSION = Gem::Version.new("0.2.1")

  def initialize(input, io: StringIO.new)
    @input = input
    @parsed = ::Template::Parser::Template.new.parse(@input)
    @io = io
  end

  def self.render(input, context = "", io: StringIO.new)
    new(input, io: io).render(context)
  end

  def render(context = "")
    if context.present?
      context = ::Code.evaluate(context)
    else
      context = ::Code::Object::Dictionnary.new
    end

    ::Template::Node::Template.new(@parsed).evaluate(context: context, io: @io)

    @io.is_a?(StringIO) ? @io.string : nil
  end
end
