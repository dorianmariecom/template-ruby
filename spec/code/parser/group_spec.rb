require "spec_helper"

RSpec.describe "Code::Parser group" do
  subject { Code::Parser.parse(input) }

  [
    [
      "(true (nothing))",
      [{ group: [{ boolean: "true" }, { group: [{ nothing: "nothing" }] }] }],
    ],
  ].each do |input, output|
    context input.inspect do
      let(:input) { input }

      it { expect(subject).to eq(output) }
    end
  end
end
