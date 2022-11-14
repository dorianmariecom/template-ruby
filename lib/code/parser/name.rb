class Code
  class Parser
    class Name < ::Code::Parser
      def parse
        return if end_of_input?
        return if next?(SPECIAL)
        return if next?(KEYWORDS)
        consume while !next?(SPECIAL) && !end_of_input?
        match(QUESTION_MARK) || match(EXCLAMATION_POINT)
        buffer!
      end
    end
  end
end
