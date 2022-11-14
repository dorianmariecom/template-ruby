require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  [
    "{}",
    "{a:1}",
    "{ a: 1 }",
    "{ :a => 1 }",
    "{ :a => 1, b: 2 }",
    "{ :a => 1, b: { c: 2 } }"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  [
    "{ /* cool */ }",
    "{ a /* cool */ : 1",
    "{ a /* cool */ => 1",
    "{ a: 1 /* cool */ }",
    "{ a: 1, /* cool */ b: 2 }",
    "{ a: 1, b /* cool */ : 2 }",
    "{ a: 1, b /* cool */ => 2 }",
    "{ a: 1, b => /* cool */ 2 }",
    "{ a: 1, b => 2 /* cool */ }",
    "{ /* cool */ **kargs }",
    "{ **kargs /* cool */ }"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
