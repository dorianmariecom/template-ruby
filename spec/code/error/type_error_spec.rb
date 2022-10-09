require "spec_helper"

RSpec.describe ::Code::Error::TypeError do
  describe "Integer" do
    context "creating an integer with a non-number exponent" do
      it "raises" do
        expect { ::Code::Object::Integer.new(1, exponent: "2") }.to raise_error(
          described_class,
        )
      end
    end

    [
      '1 / ""',
      '1 ** ""',
      '1 % ""',
      '1 - ""',
      '1 << ""',
      '1 >> ""',
      '1 & ""',
      '1 | ""',
      '1 ^ ""',
      '1 > ""',
      '1 >= ""',
      '1 < ""',
      '1 <= ""',
    ].each do |input|
      context input.inspect do
        it "raises" do
          expect { ::Code.evaluate(input) }.to raise_error(described_class)
        end
      end
    end
  end

  describe "Decimal" do
    context "creating an integer with a non-number exponent" do
      it "raises" do
        expect { ::Code::Object::Decimal.new(1, exponent: "2") }.to raise_error(
          described_class,
        )
      end
    end

    [
      '1.0 / ""',
      '1.0 ** ""',
      '1.0 * ""',
      '1.0 % ""',
      '1.0 - ""',
      '1.0 > ""',
      '1.0 >= ""',
      '1.0 < ""',
      '1.0 <= ""',
    ].each do |input|
      context input.inspect do
        it "raises" do
          expect { ::Code.evaluate(input) }.to raise_error(described_class)
        end
      end
    end
  end
end
