require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  ["a or b", "a and b", "a or b or c", "a and b and c"].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  [
    "a /* cool */ and b",
    "a and /* cool */ b",
    "a or b or c /* cool */",
    "a or b or /* cool */ c"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
