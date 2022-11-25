require "spec_helper"

RSpec.describe "range" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [["(0..1).to_list", "[0, 1]"], ["(0...1).to_list", "[0]"]].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
