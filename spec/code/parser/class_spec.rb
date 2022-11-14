require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  [
    "class A",
    "class A self.b = 1",
    "class A < B",
    "class A end",
    "class A self.b = 1 end",
    "class A < B end"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  [
    "class /* cool */ A",
    "class A /* cool */ < B",
    "class A </* cool */ B"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
