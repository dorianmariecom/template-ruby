require "spec_helper"

RSpec.describe "dictionnary" do
  let(:timeout) { 0 }
  subject { Code.evaluate(input, timeout: timeout).to_s }

  [
    %w[{} {}],
    ["{ a: 1, b: 2, c: 3 }", '{"a" => 1, "b" => 2, "c" => 3}'],
    ['{ "first_name": "Dorian" }', '{"first_name" => "Dorian"}']
  ].each do |input, output|
    context input do
      let(:input) { input }
      it { expect(subject).to eq(output) }
    end
  end
end
