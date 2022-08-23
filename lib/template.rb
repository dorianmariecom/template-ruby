class Template
  def initialize(input)
    @input = input
    @parsed = ::Template::Parser::Template.new.parse(@input)
  end

  def self.render(input, context = "")
    new(input).render(context)
  end

  def render(context = "")
    if context.present?
      context = ::Code.evaluate(context)
    else
      context = ::Code::Object::Context.new
    end

    ::Template::Node::Template.new(@parsed).evaluate(context: context).map(&:to_s).join
  end
end
