require "spec_helper"

RSpec.describe "function" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    %w[!false true],
    %w[!!true true],
    %w[!!1 true],
    ["+1", "1"],
    ["+1.0", "1.0"],
    ["+true", "true"],
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
