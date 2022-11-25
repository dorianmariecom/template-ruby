require "spec_helper"

RSpec.describe Code::Parser::Call do
  subject { Code::Parser.parse(input) }

  [
    "{}",
    "{ }",
    "{/* comment */}",
    "{ a: 1, b: 2, c: 3 }",
    '{ "first_name": "Dorian" }',
  ].each do |input|
    context input do
      let(:input) { input }
      it { subject }
    end
  end
end
