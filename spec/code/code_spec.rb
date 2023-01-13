require "spec_helper"

RSpec.describe "function" do
  it "converts nil" do
    expect(Code::Ruby.from_code(Code.evaluate("a", ruby: { a: nil }))).to eq(nil)
  end

  it "works with downcase" do
    expect(Code.evaluate("downcase", "{ downcase: 1 }")).to eq(1)
  end
end
