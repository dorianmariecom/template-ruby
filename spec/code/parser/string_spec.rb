require "spec_helper"

RSpec.describe Code::Parser::String do
  subject { described_class.new.parse(input) }

  [
    "'hello'",
    '"hello"',
    "''",
    '""',
    "'\\''",
    '"\\t"',
    "'\\r'",
    '"\\b\\f\\n\\r\\t"',
    '"\\uABCG"',
    "'\\u0123\\u4567\\u89aA\\ubBcC\\UdDeE\\ufFfF'",
    ":asc",
    "'1 + 1 = {1 + 1}'",
    "'a + b = {'{'a'}{'b'}'}'"
  ].each do |input|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect { subject }.to_not raise_error
      end
    end
  end
end
