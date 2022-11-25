require "spec_helper"

RSpec.describe Code::Parser::Function do
  subject { Code::Parser.parse(input) }

  [
    "() => {}",
    "(a, b) => { add(a, b) }",
    "(a:, b:) => { add(a, b) }"
  ].each do |input|
    context input do
      let(:input) { input }
      it { subject }
    end
  end
end
