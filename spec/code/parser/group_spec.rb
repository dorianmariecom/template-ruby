require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  ["()", "(true nothing)", "(true (nothing))"].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end
end
