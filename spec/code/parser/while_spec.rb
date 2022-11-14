require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  [
    "while false",
    "while false a end",
    "while false a",
    "until true",
    "until true a",
    "until true a end"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  [
    "while /* cool */ a",
    "while a /* cool */ b",
    "until a b /* cool */ end"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
