require "spec_helper"

RSpec.describe "function" do
  it "converts nil" do
    expect(Code::Ruby.from_code(Code.evaluate("a", ruby: { a: nil }))).to eq(nil)
  end
end
