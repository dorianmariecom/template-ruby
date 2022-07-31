require "spec_helper"

RSpec.describe Code do
  subject { described_class.evaluate(input).to_s }

  [
    ["nothing", ""],
    ["null", ""],
    ["nil", ""],
    %w[true true],
    %w[false false],
    %w[1 1],
    %w[1.2 1.2],
    %w[0b10 2],
    %w[0o10 8],
    %w[0x10 16],
    %w[1e2 100],
    %w[1.2e2.2 190.1871830953336182242521644],
    %w[1e1e1 10000000000],
    %w['hello' hello],
    %w["hello" hello],
    ["user", ""],
    ["user.first_name", ""],
    ["[true, 1, nothing]", "[true, 1, nothing]"],
    ['{a: 1, "b": 2}', '{"a" => 1, "b" => 2}'],
    %w[!true false],
    %w[!!true true],
    %w[!!nothing false],
    %w[!!1 true],
    %w[+1 1],
    %w[++++1 1],
    ["++++nothing", ""],
    %w[+{} {}],
    ["2 ** 2", "4"],
    ["2 ** 2 ** 3", "256"],
    %w[-2 -2],
    %w[--2 2],
    ["2 * 3", "6"],
    ["1 / 2", "0.5"],
    ["1 / 2 / 2", "0.25"],
    ["12 % 10", "2"],
    ["8 / -2 ** 3", "-1.0"],
    ["1 + 2 * 3 + 4", "11"],
    ["1e1.1 * 2", "25.1785082358833442084790822"],
    ["1 / 3 * 3", "0.999999999999999999999999999999999999"],
    ["1 << 2", "4"],
    ["4 >> 2", "1"],
    ["2 & 1", "0"],
    ["2 | 1", "3"],
    ["5 ^ 6", "3"],
    ["5 > 6", "false"],
    ["5 > 5", "false"],
    ["5 > 4", "true"],
    ["2 > 1 == 3 > 2", "true"],
    ["true && false", "false"],
    ["true || false", "true"],
    ["1..3", "1..3"],
    ['1 > 3 ? "Impossible" : "Sounds about right"', "Sounds about right"],
    ['1 < 3 ? "OK"', "OK"],
    ['1 < "" rescue "oops"', "oops"],
    ['"fine" rescue "oops"', "fine"],
  ].each do |(input, expected)|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect(subject).to eq(expected)
      end
    end
  end
end
