require "spec_helper"

RSpec.describe "function" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    ["1 > 2", "false"],
    ["1 < 2", "true"],
    ["1 <= 1", "true"],
    ["1 >= 1", "true"],
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
