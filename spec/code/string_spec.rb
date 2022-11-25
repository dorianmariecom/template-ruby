require "spec_helper"

RSpec.describe "string" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    ["''", ""],
    ['""', ""],
    ["'Hello Dorian'", "Hello Dorian"],
    ['"Hello Dorian"', "Hello Dorian"],
    ["'Hello \\{name}'", "Hello {name}"],
    ['"Hello \\{name}"', "Hello {name}"],
    ["'Hello {1}'", "Hello 1"],
    ['"Hello {1}"', "Hello 1"]
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
