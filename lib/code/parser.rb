class Code
  class Parser
    def initialize(input)
      @input = input
    end

    def self.parse(input)
      new(input).parse
    end

    def parse
      ::Code::Parser::Code.parse(input)
    end

    private

    attr_reader :input
  end
end
