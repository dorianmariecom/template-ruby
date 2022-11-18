class Language
  class Parser
    class RuleNotFound < Exception
    end

    attr_accessor :input, :buffer, :output, :root, :rules, :cursor

    def initialize(
      root:,
      rules:,
      input:,
      cursor: 0,
      buffer: "",
      output: Output.new
    )
      @root = root
      @rules = rules
      @input = input
      @cursor = cursor
      @buffer = buffer
      @output = output
    end

    def find_rule(name)
      (@rules + [@root]).find { |rule| rule.name == name }
    end

    def find_rule!(name)
      find_rule(name) ||
        raise(RuleNotFound.new("No rule named #{name.inspect} found"))
    end

    def parse(check_end_of_input: true)
      @root.parse(self)

      if @cursor == @input.size || !check_end_of_input
        @output.present? ? @output : Output.new(@buffer)
      else
        raise NotEndOfInput.new(self)
      end
    end

    def consume(n)
      if @cursor + n <= @input.size
        @buffer += @input[@cursor, n]
        @cursor += n
      else
        raise EndOfInput.new(self)
      end
    end

    def aka(name)
      if @buffer.empty?
        @output = Output.new({ name => @output })
      else
        @output[name] = Output.new(@buffer)
        @buffer = ""
      end
    end

    def next?(string)
      @input[@cursor...(@cursor + string.size)] == string
    end

    def buffer?
      @buffer != ""
    end

    def output?
      @output.present?
    end
  end
end
