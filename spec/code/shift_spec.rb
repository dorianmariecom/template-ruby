require "spec_helper"

RSpec.describe "shift" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [["1 >> 1", "0"], ["1 << 1", "2"]].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
