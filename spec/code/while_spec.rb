require "spec_helper"

RSpec.describe "while" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    ["while false", ""],
    ["a = 0\nwhile a < 10 a += 1 end a", "10"],
    ["until true", ""],
    ["a = 0\nuntil a > 10 a += 1 end a", "11"]
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
