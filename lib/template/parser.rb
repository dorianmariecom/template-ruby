class Template
  class Parser < ::Code::Parser
    Version = Gem::Version.new("0.1.8")

    def parse
      parts = []

      while !end_of_input?
        c = consume

        if c == OPENING_CURLY_BRACKET
          parts << { text: escape(buffer!) } if buffer?
          parts << { code: parse_code }
          match(CLOSING_CURLY_BRACKET)
          buffer!
        elsif c == BACKSLASH
          match(OPENING_CURLY_BRACKET)
        end
      end

      parts << { text: escape(buffer!) } if buffer?

      parts
    end

    private

    def escape(text)
      text.gsub(BACKSLASH + OPENING_CURLY_BRACKET, OPENING_CURLY_BRACKET)
    end
  end
end
