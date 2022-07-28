require "spec_helper"

RSpec.describe Template do
  subject { described_class.render(input, input_context) }

  [
    ["Hello World", "", "Hello World"],
    ["1 + 1 = {2}", "", "1 + 1 = 2"],
    ["Hello {name}", '{ name: "Dorian" }', "Hello Dorian"],
    [
      "Hello {user.first_name}",
      '{ user: { first_name: "Dorian" } }',
      "Hello Dorian",
    ],
    ["Hello {user.first_name}", "", "Hello "],
  ].each do |(input, input_context, expected)|
    context "#{input.inspect} #{input_context.inspect}" do
      let(:input) { input }
      let(:input_context) { input_context }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end
end
