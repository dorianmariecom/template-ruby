require "spec_helper"
require "prime"

RSpec.describe Template do
  let!(:ruby) { {} }
  let!(:input_context) { "" }
  let!(:timeout) { 0 }
  subject do
    Template.render(input, input_context, ruby: ruby, timeout: timeout)
  end

  [
    ["Hello World", "", "Hello World"],
    ["1 + 1 = {2}", "", "1 + 1 = 2"],
    ["Hello {name}", '{ name: "Dorian" }', "Hello Dorian"],
    [
      "Hello {user.first_name}",
      '{ user: { first_name: "Dorian" } }',
      "Hello Dorian"
    ],
    ["{add(1, 2)", "add = (a, b) => { a + b } { add: context(:add) }", "3"],
    ["Hello {", "", "Hello "],
    ["{{a: 1}.each { |k, v| print(k) } nothing", "", "a"],
    ["{{a: 1}.each { |k, v| puts(k) } nothing", "", "a\n"],
    ["", "", ""]
  ].each do |(input, input_context, expected)|
    context "#{input.inspect} #{input_context.inspect}" do
      let(:input) { input }
      let(:input_context) { input_context }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end

  context "with a function from ruby" do
    let!(:ruby) { { prime: ->(n) { n.prime? } } }
    let!(:input) { "{prime(19201)" }

    it "calls the ruby function" do
      expect(subject).to eq("false")
    end
  end

  context "with a function from ruby in an object" do
    let!(:ruby) { { Prime: { prime: ->(n) { n.prime? } } } }
    let!(:input) { "{Prime.prime(19201)" }

    it "calls the ruby function" do
      expect(subject).to eq("false")
    end
  end
end
