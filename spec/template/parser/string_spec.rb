require "spec_helper"

RSpec.describe Template::Parser::String do
  subject { described_class.new.parse(input) }

  [
    ["'hello'", { string: "hello" }],
    ['"hello"', { string: "hello" }],
    ["''", { string: "" }],
    ['""', { string: "" }],
    ["'\\''", { string: "'" }],
    ['"\\t"', { string: "\\t" }],
    ["'\\r'", { string: "\\r" }],
    ['"\\b\\f\\n\\r\\t"', { string: "\\b\\f\\n\\r\\t" }],
    ['"\\uABCG"', { string: "uABCG" }],
    [
      "'\\u0123\\u4567\\u89aA\\ubBcC\\UdDeE\\ufFfF'",
      { string: "\\u0123\\u4567\\u89aA\\ubBcC\\UdDeE\\ufFfF" }
    ]
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end

  %w['hello hello" True FALSE nothing].each do |input|
    context input.inspect do
      let(:input) { input }

      it "fails" do
        expect { subject }.to raise_error(Parslet::ParseFailed)
      end
    end
  end
end
