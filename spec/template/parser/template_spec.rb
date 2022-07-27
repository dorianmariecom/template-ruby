require "spec_helper"

RSpec.describe Template::Parser::Template do
  subject { described_class.new.parse(input) }

  [
    ["hello", [{ text: "hello" }]],
    ["hello {name}", [{ text: "hello " }, { code: [{ name: "name" }] }]],
    ["{name", [{ code: [{ name: "name" }] }]]
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end
end
