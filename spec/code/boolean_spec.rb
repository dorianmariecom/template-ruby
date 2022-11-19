require "spec_helper"

RSpec.describe "nothing" do
  subject { Code.evaluate(input).to_s }

  [
    ["true", "true"],
    ["false", "false"],
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
