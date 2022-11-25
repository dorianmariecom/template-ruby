require "spec_helper"

RSpec.describe Code::Parser::ChainedCall do
  subject { Code::Parser.parse(input) }

  [
    "a.b",
    "user.first_name",
    "user.admin?",
    'user.update!(name: "Dorian")'
  ].each do |input|
    context input do
      let(:input) { input }
      it { subject }
    end
  end
end
