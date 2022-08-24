require "spec_helper"

RSpec.describe Code::Parser::Call do
  subject { described_class.new.parse(input) }

  [
    [
      "user.first_name",
      { call: { left: { name: "user" }, right: [{ name: "first_name" }] } },
    ],
    [
      "3.times",
      {
        call: {
          left: {
            number: {
              base_10: {
                integer: {
                  whole: "3",
                },
              },
            },
          },
          right: [{
            name: "times",
          }],
        },
      },
    ],
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end

  [
    "User.first",
    "User.first(10)",
    'User.find_by(name: "Dorian")',
    "User.update_all(**attributes)",
    "User.each(&block)",
    "user.update(*args)",
    "sort([1, 2, 3], :asc)",
    "render()",
    "render(item)",
    "Renderer.render(item)",
    "render(item) { 'Hello' }",
    "render(item) { |item| item * 2 }",
    "render(item) { |item1, item2| item1 + item2 }",
    "render(item) do 'Hello' end",
    "render(item) do |item| item * 2 end",
    "render(item) do |item1, item2| item1 + item2 end",
    "(1..2).any?(&:even?)",
    "(2..5).select { |i| i.even? }.any? { |n| n.even? }",
  ].each do |input|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect { subject }.to_not raise_error
      end
    end
  end
end
