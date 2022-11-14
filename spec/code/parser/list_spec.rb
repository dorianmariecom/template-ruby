require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  ["[]", "[1]", "[1,2]", "[1,[true]]"].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  [
    "[ /* cool */ ]",
    "[ /* cool */ 1 ]",
    "[ 1 /* cool */ ]",
    "[ 1, /* cool */ 2 ]",
    "[ 1, 2 /* cool */ ]"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
