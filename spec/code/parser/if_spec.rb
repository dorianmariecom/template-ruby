require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  [
    "if b",
    "if a b",
    "if a end",
    "if b a end",
    "if a b else c",
    "if a b elsif c d else e",
    "if a b else if c d",
    "if a b else unless c d"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  [
    "if /* cool */ a",
    "if a /* cool */ b",
    "if a b /* cool */ else c",
    "if a b else /* cool */ c",
    "if a b elsif /* cool */ c d else e",
    "if a b else /* cool */ if c d",
    "if a b else if /* cool */ c d",
    "if a b else unless /* cool */ c d"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
