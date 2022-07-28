require "spec_helper"

RSpec.describe Code::Parser::Boolean do
  subject { described_class.new.parse(input) }

  [
    ["true", { boolean: "true" }],
    ["false", { boolean: "false" }],
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end
end
