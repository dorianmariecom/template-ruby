require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  ["a ? b : c", "a ? b", "a ? b ? c : d : e", "a ? b ? c : d"].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  [
    "a /* cool */ ? b : c",
    "a ? /* cool */ b",
    "a ? b /* cool */ ? c : d : e",
    "a ? b ? /* cool */ c : d"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
