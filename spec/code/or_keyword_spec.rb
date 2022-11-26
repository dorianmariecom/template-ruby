require "spec_helper"

RSpec.describe "or keyword" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [["true or false", "true"], ["true and false", "false"], ["random = 1 random", "1"]].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
