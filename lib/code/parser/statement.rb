class Code
  class Parser
    class Statement < Language
      def root
        ::Code::Parser::OrKeyword
      end
    end
  end
end
