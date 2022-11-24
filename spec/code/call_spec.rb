require "spec_helper"

RSpec.describe "call" do
  let(:timeout) { 0 }

  context "inspecting the io" do
    let(:io) { StringIO.new }

    subject do
      Code.evaluate(input, io: io, timeout: timeout)
      io.string
    end

    [["puts(true)", "true\n"], %w[print(false) false]].each do |input, output|
      context input do
        let(:input) { input }
        it { expect(subject).to eq(output) }
      end
    end
  end
end
