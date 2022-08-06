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

          right.truthy? ? @left.evaluate(context) : ::Code::Object::Nothing.new
        elsif operator == UNLESS_KEYWORD
          right = @right.evaluate(context)

          right.truthy? ? ::Code::Object::Nothing.new : @left.evaluate(context)
        elsif operator == WHILE_KEYWORD
          left = ::Code::Object::Nothing.new

          left = @left.evaluate(context) while @right.evaluate(context).truthy?

          left
        elsif operator == UNTIL_KEYWORD
          left = ::Code::Object::Nothing.new

          left = @left.evaluate(context) until @right.evaluate(context).truthy?

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
