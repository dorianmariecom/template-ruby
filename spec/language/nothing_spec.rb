require "spec_helper"

nothing =
  Language.create do
    root { (str("nothing") | str("null") | str("nil")).aka(:nothing) }
  end

RSpec.describe "nothing" do
  [
    ["nothing", { nothing: "nothing" }],
    ["null", { nothing: "null" }],
    ["nil", { nothing: "nil" }]
  ].each do |input, output|
    context input do
      it { expect(nothing.parse(input)).to eq(output) }
    end
  end

  %w[anothing nothinga].each do |input|
    context input do
      it do
        expect do nothing.parse(input) end.to raise_error(
          Language::Parser::Interuption
        )
      end
    end
  end
end
