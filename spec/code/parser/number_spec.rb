require "spec_helper"

RSpec.describe Code::Parser::Number do
  subject { described_class.new.parse(input) }

  [
    ["1", { number: { base_10: { integer: { whole: "1" } } } }],
    ["3", { number: { base_10: { integer: { whole: "3" } } } }],
    ["1.0", { number: { base_10: { decimal: { whole: "1", decimal: "0" } } } }],
    [
      "-1.0",
      {
        number: {
          base_10: {
            decimal: {
              sign: "-",
              whole: "1",
              decimal: "0"
            }
          }
        }
      }
    ],
    [
      "+1.0",
      {
        number: {
          base_10: {
            decimal: {
              sign: "+",
              whole: "1",
              decimal: "0"
            }
          }
        }
      }
    ],
    ["0", { number: { base_10: { integer: { whole: "0" } } } }],
    ["+0", { number: { base_10: { integer: { sign: "+", whole: "0" } } } }],
    ["-0", { number: { base_10: { integer: { sign: "-", whole: "0" } } } }],
    ["0b010", { number: { base_2: "010" } }],
    ["0o01234567", { number: { base_8: "01234567" } }],
    [
      "0x0123456789aAbBcCdDeEfF",
      { number: { base_16: "0123456789aAbBcCdDeEfF" } }
    ],
    [
      "10e20",
      {
        number: {
          base_10: {
            integer: {
              whole: "10",
              exponent: {
                integer: {
                  whole: "20"
                }
              }
            }
          }
        }
      }
    ],
    [
      "10.34e23.45",
      {
        number: {
          base_10: {
            decimal: {
              whole: "10",
              decimal: "34",
              exponent: {
                decimal: {
                  whole: "23",
                  decimal: "45"
                }
              }
            }
          }
        }
      }
    ],
    [
      "+10e-20e1.0",
      {
        number: {
          base_10: {
            integer: {
              sign: "+",
              whole: "10",
              exponent: {
                integer: {
                  sign: "-",
                  whole: "20",
                  exponent: {
                    decimal: {
                      whole: "1",
                      decimal: "0"
                    }
                  }
                }
              }
            }
          }
        }
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
