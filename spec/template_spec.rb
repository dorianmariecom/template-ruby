# frozen_string_literal: true

require "spec_helper"

RSpec.describe Code do
  [
    ["{name = :Dorian nothing}Hello {name}", "Hello Dorian"]
  ].each do |input, expected|
    it "#{input} == #{expected}" do
      expect(Template.evaluate(input)).to eq(expected)
    end
  end
end
