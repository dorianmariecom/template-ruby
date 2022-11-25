require "spec_helper"

RSpec.describe "number" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    ["[]", "[]"],
    ["[1, 2, 3]", "[1, 2, 3]"],
    ["[[true]]", "[[true]]"],
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
