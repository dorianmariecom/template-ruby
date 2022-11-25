require "spec_helper"

RSpec.describe Code::Parser::String do
  subject { Code::Parser.parse(input) }

  [
    "''",
    '""',
    "'Hello Dorian'",
    '"Hello Dorian"',
    "'Hello \\{name}'",
    '"Hello \\{name}"',
    "'Hello {name}'",
    '"Hello {name}"'
  ].each do |input|
    context input do
      let(:input) { input }
      it { subject }
    end
  end
end
