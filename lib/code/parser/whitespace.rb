class Code
  class Parser
    class Whitespace < Language
      def space
        str(" ")
      end

      def newline
        str("\n")
      end

      def hashtag
        str("#")
      end

      def slash
        str("/")
      end

      def asterisk
        str("*")
      end

      def hash_comment
        hashtag << (newline.absent << any).repeat << newline.maybe
      end

      def double_slash_comment
        slash << slash << (newline.absent << any).repeat << newline.maybe
      end

      def multi_line_comment
        slash << asterisk << ((asterisk << slash).absent << any).repeat <<
          asterisk.maybe << slash.maybe
      end

      def without_newline
        (space | multi_line_comment).repeat(1)
      end

      def root
        (
          space | newline | hash_comment | double_slash_comment |
            multi_line_comment
        ).repeat(1)
      end
    end
  end
end
