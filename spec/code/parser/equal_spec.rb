require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  [
    "a = 1",
    "a += 1",
    "a -= 1",
    "a *= 1",
    "a /= 1",
    "a <<= 1",
    "a >>= 1",
    "a &= 1",
    "a |= 1",
    "a ^= 1",
    "a %= 1",
    "a ||= 1",
    "a &&= 1",
    "a = b = 1",
    "a = b += c"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  [
    "a /* cool */ = 1",
    "a += /* cool */ 1",
    "a = b -= /* cool */ 1",
    "a = b /* cool */ *= 1"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
