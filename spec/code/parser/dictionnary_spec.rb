require "spec_helper"

RSpec.describe Code::Parser::Dictionnary do
  subject { described_class.new.parse(input) }

  [
    '{name: "Dorian"}',
    '{a: true, "b": false}',
    "{ true => 1, false => 2}",
  ].each do |input|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect { subject }.to_not raise_error
      end
    end
  end
end
