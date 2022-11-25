require "spec_helper"

RSpec.describe "Code::Parser" do
  subject { Code::Parser.parse(input) }

  [
    ["", []],
    ["  ", []],
    ["\n", []],
    ["nothing", [{ nothing: "nothing" }]],
    ["  nothing  ", [{ nothing: "nothing" }]],
    [
      "nothing null nil",
      [{ nothing: "nothing" }, { nothing: "null" }, { nothing: "nil" }],
    ],
  ].each do |input, output|
    context input.inspect do
      let(:input) { input }

      it { expect(subject).to eq(output) }
    end
  end
end
