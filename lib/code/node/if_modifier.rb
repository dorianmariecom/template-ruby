class Code
  class Node
    class IfModifier
      IF_KEYWORD = :if
      UNLESS_KEYWORD = :unless
      WHILE_KEYWORD = :while
      UNTIL_KEYWORD = :until

      def initialize(if_modifier)
        @left = ::Code::Node::Statement.new(if_modifier.fetch(:left))
        @operator = if_modifier.fetch(:operator)
        @right = ::Code::Node::Statement.new(if_modifier.fetch(:right))
      end

      def evaluate(context)
        if operator == IF_KEYWORD
          right = @right.evaluate(context)

          if right.truthy?
            @left.evaluate(context)
          else
            ::Code::Object::Nothing.new
          end
        elsif operator == UNLESS_KEYWORD
          right = @right.evaluate(context)

          if right.truthy?
            ::Code::Object::Nothing.new
          else
            @left.evaluate(context)
          end
        elsif operator == WHILE_KEYWORD
          left = ::Code::Object::Nothing.new

          while @right.evaluate(context).truthy?
            left = @left.evaluate(context)
          end

          left
        elsif operator == UNTIL_KEYWORD
          left = ::Code::Object::Nothing.new

          until @right.evaluate(context).truthy?
            left = @left.evaluate(context)
          end

          left
        else
          raise NotImplementedError.new(operator.inspect)
        end
      end

      private

      def operator
        @operator.to_sym
      end
    end
  end
end
