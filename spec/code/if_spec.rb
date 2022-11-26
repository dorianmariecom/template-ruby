require "spec_helper"

RSpec.describe "if" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    ["if true 1", "1"],
    ["unless false 1", "1"],
    ["if false 1", ""],
    ["unless true 1", ""],
    ["if false 1 else 2", "2"],
    ["if false 1 elsif true 2", "2"],
    ["if false 1 elsif false 2", ""],
    ["if false 1 else if true 2", "2"],
    ["if false 1 else if false 2", ""],
    ["if false 1 else unless false 2", "2"],
    ["if false 1 else unless true 2", ""]
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
