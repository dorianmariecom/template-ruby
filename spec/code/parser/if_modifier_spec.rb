require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  ["a if b", "a if b if c", "a unless b"].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  [
    "a /* cool */ if b",
    "a if /* cool */ b",
    "a if b if c /* cool */",
    "a unless b if /* cool */ c"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
