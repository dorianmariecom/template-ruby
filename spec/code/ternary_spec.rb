require "spec_helper"

RSpec.describe "ternary" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    ["true ? 1", "1"],
    ["false ? 1", ""],
    ["true ? 1 : 2", "1"],
    ["false ? 1 : 2", "2"],
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
