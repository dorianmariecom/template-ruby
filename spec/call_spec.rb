require "spec_helper"

RSpec.describe Code do
  let!(:input) { "" }
  let!(:context) { "" }
  let!(:io) { StringIO.new }
  let!(:timeout) { 0 }
  let!(:ruby) { {} }

  subject do
    Code.evaluate(input, context, io: io, timeout: timeout, ruby: ruby).to_s
  end

  [
    %w[(1..2).any?(&:even?) true],
    %w[(1..1).any?(&:even?) false],
    %w[(3..3).any?(&:even?) false],
    %w[(2..5).any?(&:even?) true],
    ["(2..5).any? { |n| n.even? }", "true"],
    ["(2..5).select { |i| i.even? }.any? { |n| n.even? }", "true"]
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end
end
