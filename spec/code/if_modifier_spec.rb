require "spec_helper"

RSpec.describe "if modifier" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    ["1 if true", "1"],
    ["1 if false", ""],
    ["1 unless true", ""],
    ["1 unless false", "1"],
    ["a = 0 a += 1 while a < 10 a", "10"],
    ["a = 0 a += 1 until a > 10 a", "11"],
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
