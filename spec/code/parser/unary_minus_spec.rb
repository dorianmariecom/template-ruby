require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  %w[-1 +a -+--1].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  ["- /* cool */ 1"].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
