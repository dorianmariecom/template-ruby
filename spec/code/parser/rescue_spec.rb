require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  ["0/0 rescue a", "0/0 rescue 0/0 rescue 'nope'"].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  [
    "a /* cool */ rescue b",
    "a rescue /* cool */ b",
    "a rescue b /* cool */ rescue c",
    "a rescue b eescue /* cool */ c"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
