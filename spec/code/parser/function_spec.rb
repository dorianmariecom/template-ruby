require "spec_helper"

RSpec.describe ::Code::Parser do
  subject { ::Code::Parser.parse(input) }

  [
    "()=>{}",
    "() => {}",
    "(a, b) => { add(a, b) }",
    "(a, b = 1, c:, d: 2, *e, **f) => { }",
    "(a?, b! = 1, c?:, d?: 2, *e?, *f!, **g?, **h!) => { }"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { subject }
    end
  end

  [
    "(/* cool */)=>{}",
    "(/* cool */ a)=>{}",
    "(/* cool */ a:)=>{}",
    "(a /* cool */ )=>{}",
    "(a /* cool */ :)=>{}",
    "(a /* cool */ => 1)=>{}",
    "(a = /* cool */ 1)=>{}",
    "(a = 1 /* cool */)=>{}",
    "(a, /* cool */ b)=>{}",
    "(a, b /* cool */)=>{}",
    "(a, b /* cool */ = 1)=>{}",
    "(a, b: /* cool */)=>{}",
    "() /* cool */ => {}",
    "() => /* cool */ {}",
    "() => { /* cool */ }"
  ].each do |input|
    context input do
      let!(:input) { input }

      it { expect(subject.to_json).to include("cool") }
    end
  end
end
