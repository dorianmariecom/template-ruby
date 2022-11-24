require "spec_helper"

RSpec.describe "group" do
  subject { Code.evaluate(input).to_s }

  [["(true false)", "false"]].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
