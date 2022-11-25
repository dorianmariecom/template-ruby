require "spec_helper"

RSpec.describe "chained call" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [["[1, 2, 3].select { |n| n.even? }", "[2]"], ["[1, 2, 3].select { |n| n.even? }.select { |n| n.odd? }", "[]"]].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
