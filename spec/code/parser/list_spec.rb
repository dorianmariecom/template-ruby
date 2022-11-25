require "spec_helper"

RSpec.describe Code::Parser::Call do
  subject { Code::Parser.parse(input) }

  [
    "[]",
    "[ ]",
    "[/* comment */]",
    "[1, 2, 3]",
    "['hello', 1, true, [false, nothing]]",
  ].each do |input|
    context input do
      let(:input) { input }
      it { subject }
    end
  end
end
