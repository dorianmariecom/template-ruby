# frozen_string_literal: true

class Template
  class Parser
    def initialize(input)
      @input = input
    end

    def self.parse(input)
      new(input).parse
    end

    def parse
      parts = []
      text = +""
      cursor = 0

      while cursor < input.length
        if input[cursor, 2] == '\\{'
          text << "{"
          cursor += 2
        elsif input[cursor] == "{"
          parts << { text: text } unless text.empty?
          text = +""

          closing_cursor = closing_curly_bracket(cursor + 1)
          code = input[(cursor + 1)...closing_cursor]
          parts << { code: ::Code::Parser.parse(code).to_raw }
          cursor = closing_cursor + (closing_cursor < input.length ? 1 : 0)
        else
          text << input[cursor]
          cursor += 1
        end
      end

      parts << { text: text } unless text.empty?
      parts << { text: "" } if parts.empty?
      Language::Output.from_raw(parts)
    end

    private

    attr_reader :input

    def closing_curly_bracket(cursor)
      depth = 0
      quote = nil

      while cursor < input.length
        character = input[cursor]

        if quote
          if character == "\\"
            cursor += 2
            next
          end

          quote = nil if character == quote
        elsif ["'", '"'].include?(character)
          quote = character
        elsif character == "{"
          depth += 1
        elsif character == "}"
          return cursor if depth.zero?

          depth -= 1
        end

        cursor += 1
      end

      cursor
    end
  end
end
