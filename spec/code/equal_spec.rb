require "spec_helper"

RSpec.describe "function" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    ["a = 1 a", "1"],
    ["a = 1 a += 1 a", "2"],
    ["a = 1 a -= 1 a", "0"],
    ["a = 1 a *= 2 a", "2"],
    ["a = 1 a /= 2 a", "0.5"],
    ["a = 10 a %= 2 a", "0"],
    ["a = 1 a >>= 1 a", "0"],
    ["a = 1 a <<= 1 a", "2"],
    ["a = 1 a |= 2 a", "3"],
    ["a = 1 a ^= 2 a", "3"],
    ["a = false a ||= true a", "true"],
    ["a = false a &&= true a", "false"],
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
