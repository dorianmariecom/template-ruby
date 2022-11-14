require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  ["a ** b", "a ** b ** c ** d"].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  ["1 /* cool */ ** 2", "1 ** /* cool */ 2"].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
