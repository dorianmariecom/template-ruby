class Template
  class Parser
    def initialize(input)
      @input = input
    end

    def self.parse(input)
      new(input).parse
    end

    def parse
      ::Template::Parser::Template.parse(input)
    end

    private

    attr_reader :input
  end
end
