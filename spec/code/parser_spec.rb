require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  ["(1..2).any?(&:even?)"].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end
end
