require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  %w[true false].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end
end
