class Code
  class Parser
    class Operation < ::Code::Parser
      def initialize(input, operators:, subclass:, **kargs)
        super(input, **kargs)

        @operators = operators
        @subclass = subclass
      end

      def parse
        previous_cursor = cursor
        left = parse_subclass(subclass)

        if left
          previous_cursor = cursor
          comments = parse_comments
          right = []

          while operator = match(operators)
            p operator
            comments_before = parse_comments
            statement = parse_subclass(subclass)
            comments_after = parse_comments

            if statement
              right << {
                statement: statement,
                operator: operator,
                comments_before: comments_before,
                comments_after: comments_after
              }.compact
            else
              @cursor = previous_cursor
              buffer!
              break
            end
          end

          if right.empty?
            @cursor = previous_cursor
            buffer!
            left
          else
            right[-1].delete(:comments_after)

            {
              operation: {
                left: left,
                right: right,
                comments: comments
              }.compact
            }
          end
        else
          @cursor = previous_cursor
          buffer!
          return
        end
      end

      private

      attr_reader :operators, :subclass
    end
  end
end
