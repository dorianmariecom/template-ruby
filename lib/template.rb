# frozen_string_literal: true

class Template
  GLOBALS = %i[output error context object].freeze
  DEFAULT_TIMEOUT = 0

  def initialize(
    input,
    output: StringIO.new,
    error: StringIO.new,
    timeout: DEFAULT_TIMEOUT
  )
    @input = input
    @output = output
    @error = error
    @timeout = timeout || DEFAULT_TIMEOUT
    @context = ::Code::Object::Context.new
  end

  def self.parse(input, timeout: DEFAULT_TIMEOUT)
    Timeout.timeout(timeout) { Parser.parse(input).to_raw }
  end

  def self.evaluate(
    input,
    output: StringIO.new,
    error: StringIO.new,
    timeout: DEFAULT_TIMEOUT
  )
    new(input, output:, error:, timeout:).evaluate
  end

  def evaluate
    Timeout.timeout(timeout) do
      parsed = Template.parse(input)
      Node::Template.new(parsed).evaluate(context:, output:, error:)

      if output.is_a?(StringIO)
        output.string
      else
        ""
      end
    end
  end

  private

  attr_reader :input, :timeout, :output, :error, :context
end
