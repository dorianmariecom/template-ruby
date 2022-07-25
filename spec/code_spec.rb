require "spec_helper"

RSpec.describe Code do
  subject { described_class.evaluate(input).to_s }

  [
    ["nothing", ""],
    ["null", ""],
    ["nil", ""],
    ["true", "true"],
    ["false", "false"],
    ["1", "1"],
    ["1.2", "1.2"],
    ["0b10", "2"],
    ["0o10", "8"],
    ["0x10", "16"],
    ["1e2", "100"],
    ["1.2e2.2", "190.1871830953336182242521644"],
    ["1e1e1", "10000000000"],
    ["'hello'", "hello"],
    ['"hello"', "hello"],
    ['user', ""],
    ['user.first_name', ""],
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end
end
