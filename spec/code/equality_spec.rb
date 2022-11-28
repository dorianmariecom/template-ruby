require "spec_helper"

RSpec.describe "while" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [["1 == 1", "true"], ["1 == 1 and 2 == 2", "true"]].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
