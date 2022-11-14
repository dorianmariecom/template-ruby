require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  [
    "''",
    '""',
    ":a",
    ":even?",
    "'Hello Dorian'",
    '"Hello Dorian"',
    "'Hello \\' Dorian'",
    '"Hello \\" Dorian"',
    "'Hello \\{name}'",
    '"Hello \\{name}',
    "'Hello {name}'",
    '"Hello {name}',
    '"Hello \\n\\a\\{"',
    "'Hello \\n\\a\\{'"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end
end
