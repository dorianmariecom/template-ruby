require "spec_helper"

RSpec.describe Template::Parser::Boolean do
  subject { described_class.new.parse(input) }

  [
    ["true", { boolean: "true" }],
    ["false", { boolean: "false" }]
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end

  %w[True FALSE nothing].each do |input|
    context input.inspect do
      let(:input) { input }

      it "fails" do
        expect { subject }.to raise_error(Parslet::ParseFailed)
      end
    end
  end
end
