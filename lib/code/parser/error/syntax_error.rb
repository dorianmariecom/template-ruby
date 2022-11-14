class Code
  class Parser
    class Error
      class SyntaxError < ::Code::Parser::Error
        def initialize(
          message,
          input:,
          line:,
          column:,
          offset_lines:,
          offset_columns:
        )
          @message = message
          @input = input
          @line = line
          @column = column
          @offset_lines = offset_lines
          @offset_columns = offset_columns
        end

        def message
          @message + "\n\n" + line_message + "\n" + " " * column +
            "^" * offset_columns
        end

        private

        def line_message
          input.lines[line..(line + offset_lines)].join
        end

        attr_reader :input, :line, :column, :offset_lines, :offset_columns
      end
    end
  end
end
