require "spec_helper"

RSpec.describe Code::Parser::List do
  subject { described_class.new.parse(input) }

  [
    [
      "[true, false]",
      {
        list: [
          { code: [{ boolean: "true" }] },
          { code: [{ boolean: "false" }] },
        ],
      },
    ],
    [
      "[nothing, a]",
      { list: [{ code: [{ nothing: "nothing" }] }, { code: [{ name: "a" }] }] },
    ],
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end
end
