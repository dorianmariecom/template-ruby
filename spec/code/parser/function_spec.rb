require "spec_helper"

RSpec.describe Code::Parser::Function do
  subject { described_class.new.parse(input) }

  [
    "() => {}",
    '() => { "Hello" }',
    "(a) => { }",
    "(a = 1)=> {}",
    "(a, b) =>{}",
    "(a, b = 2, c = b)=>{}",
    "(a:)=>{}",
    "(a:, b:)=>{}",
    "(a, b:, c)=>{}",
    "(a:, b: 1)=>{}",
    "(a, b: 1, c)=>{}",
    "(*args)=>{}",
    "(*args, **kargs)=>{}",
    "(&block)=>{}",
    "(a = b = 1 + 1 b)=>{}",
    "(a: b = 1 + 1 b)=>{}",
  ].each do |input|
    context input.inspect do
      let(:input) { input }

      it "succeeds" do
        expect { subject }.to_not raise_error
      end
    end
  end
end
