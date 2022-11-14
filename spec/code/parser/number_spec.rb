require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  %w[
    1
    100
    0
    1_000
    1.34
    1_000.300_400
    0x10
    0o10
    0b10
    0b1_0000_0000
  ].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end
end
