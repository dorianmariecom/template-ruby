require "spec_helper"

RSpec.describe Code::Parser::Number do
  subject { Code::Parser.parse(input) }

  %w[0 1 1.1 123.123 1_000.12_244 0xf0 0o70 0b10].each do |input|
    context input do
      let(:input) { input }
      it { subject }
    end
  end
end
