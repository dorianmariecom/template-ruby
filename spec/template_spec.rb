# frozen_string_literal: true

require "spec_helper"

RSpec.describe Code do
  [
    ["Hello {name}", "{name: :Dorian}", "Hello Dorian"],
  ].each do |input, context, expected|
    it "#{input} (#{context}) == #{expected}" do
      expect(Template.evaluate(input, context)).to eq(expected)
    end
  end
end
