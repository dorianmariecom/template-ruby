require "spec_helper"

RSpec.describe Code::Parser::Dictionnary do
  subject { described_class.new.parse(input) }

  [
    [
      '{a: true, "b": false}',
      {
        dictionnary: [
          { key: { name: "a" }, value: [{ boolean: "true" }] },
          { key: { string: "b" }, value: [{ boolean: "false" }] }
        ]
      }
    ],
    [
      "{ true => 1, false => 2}",
      {
        dictionnary: [
          {
            key: [{ boolean: "true" }],
            value: [{ number: { base_10: { integer: { whole: "1" } } } }]
          },
          {
            key: [{ boolean: "false" }],
            value: [{ number: { base_10: { integer: { whole: "2" } } } }]
          }
        ]
      }
    ]
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end
end
