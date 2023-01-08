require "spec_helper"

RSpec.describe "string" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    ["''", ""],
    ['""', ""],
    %w[:hello hello],
    %w[:admin? admin?],
    %w[:update! update!],
    ["'Hello Dorian'", "Hello Dorian"],
    ['"Hello Dorian"', "Hello Dorian"],
    ["'Hello \\{name}'", "Hello {name}"],
    ['"Hello \\{name}"', "Hello {name}"],
    ["'Hello {1}'", "Hello 1"],
    ['"Hello {1}"', "Hello 1"],
    ['"Hello".include?("H")', "true"]
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
