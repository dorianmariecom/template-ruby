require "spec_helper"

RSpec.describe "function" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [["2 ** 3", "8"], ["2 ** 3 ** 2", "512"]].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
