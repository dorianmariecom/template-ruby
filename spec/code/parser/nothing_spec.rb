require "spec_helper"

RSpec.describe Code::Parser::Nothing do
  subject { described_class.new.parse(input) }

  [
    ["nothing", { nothing: "nothing" }],
    ["null", { nothing: "null" }],
    ["nil", { nothing: "nil" }]
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end
end
