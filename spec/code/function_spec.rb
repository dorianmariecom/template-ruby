require "spec_helper"

RSpec.describe "function" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    ["even? = (i) => { i.even? } even?(2)", "true"],
    ["even? = (i:) => { i.even? } even?(i: 2)", "true"],
    ["add = (a, b) => { a + b } add(1, 2)", "3"],
    ["minus = (a:, b:) => { a - b } minus(b: 1, a: 2)", "1"]
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
