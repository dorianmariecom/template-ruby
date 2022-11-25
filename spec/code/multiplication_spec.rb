require "spec_helper"

RSpec.describe "multiplication" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    ["2 * 3", "6"],
    ["2 * 3 + 2", "8"],
    ["2 / 4", "0.5"],
    ["4 % 3", "1"]
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
