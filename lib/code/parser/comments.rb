class Code
  class Parser
    class Comments < ::Code::Parser
      def initialize(input, whitespace: WHITESPACE, **kargs)
        super(input, **kargs)
        @whitespace = whitespace
        @has_line_comments = whitespace.include?(NEWLINE)
      end

      def parse
        comments = []

        while next?(whitespace) || next?(SLASH + ASTERISK) ||
                (line_comments? && (next?(SLASH + SLASH) || next?(HASH)))
          consume while next?(whitespace)
          buffer!

          if match(SLASH + SLASH) || match(HASH)
            consume while !next?(NEWLINE) && !end_of_input?
            match(NEWLINE)
            comments << buffer
          end

          consume while next?(whitespace)
          buffer!

          if match(SLASH + ASTERISK)
            consume while !next?(ASTERISK + SLASH) && !end_of_input?
            match(ASTERISK + SLASH)
            comments << buffer
          end
        end

        comments.empty? ? nil : comments
      end
    end

    private

    attr_reader :whitespace, :has_line_comments

    def line_comments?
      !!has_line_comments
    end
  end
end
