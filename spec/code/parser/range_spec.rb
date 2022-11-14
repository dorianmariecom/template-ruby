require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  ["a..b"].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  ["a /* cool */ .. b", "a .. /* cool */ b"].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
