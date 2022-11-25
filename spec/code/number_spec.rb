require "spec_helper"

RSpec.describe "number" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    %w[0 0],
    %w[1.1 1.1],
    %w[0x10 16],
    %w[0o10 8],
    %w[0b10 2],
    %w[1e1 10],
    %w[1.0e1 10.0],
    %w[10e1.0 100.0]
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
