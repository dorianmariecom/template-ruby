require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  [
    "a.b",
    "a.b.c",
    "a(1).b.c(2)",
    "user.first_name",
    "User.all",
    "User::Email.first",
    "User.each do |user| user.update(created_at: Time.now) end"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  [
    "a /* cool */ . b",
    "a . /* cool */ b",
    "a . # cool\n /* cool */ b"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
