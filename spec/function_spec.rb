require "spec_helper"

RSpec.describe Code do
  subject { described_class.evaluate(input).to_s }

  [
    ['hello = () => { "Hello" } hello', "Hello"],
    ['add = (a, b) => { a + b } add(1, 2)', "3"],
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end
end
