require "spec_helper"

RSpec.describe Code::Parser::Call do
  subject { Code::Parser.parse(input) }

  [
    "a",
    "hello",
    "hello()",
    "render(user)",
    'render(user, first_name: "Dorian")',
    "render { }",
    "render do end",
    "render { |name| name.upcase }",
    "render(user) { |name| name.upcase }",
    "render(user) do |name| name.upcase end",
    'render { "Dorian" }',
    'render(user) { "Dorian" }',
    'render(user) do "Dorian" end'
  ].each do |input|
    context input do
      let(:input) { input }
      it { subject }
    end
  end
end
