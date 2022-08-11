require "spec_helper"

RSpec.describe Code do
  subject { described_class.evaluate(input).to_s }

  [
    ['hello = () => { "Hello" } hello', "Hello"],
    ['add = (a, b) => { a + b } add(1, 2)', "3"],
    ['add = (a:, b:) => { a + b } add(a: 1, b: 2)', "3"],
    ['power = (a:, b:) => { a ** b } power(b: 2, a: 1)', "1"],
    ['add(1, 2)', ""],
    ['Math.add(1, 2)', ""],
    ['power = (a, b:) => { a ** b } power(b: 2, 1)', "4"],
    ['power = (a:, b) => { a ** b } power(b: 1, 3, a: 2)', "8"],
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end
end
