class Code
  class Node
    class IfModifier < Node
      IF_KEYWORD = :if
      UNLESS_KEYWORD = :unless
      WHILE_KEYWORD = :while
      UNTIL_KEYWORD = :until

      def initialize(if_modifier)
        @left = ::Code::Node::Statement.new(if_modifier.fetch(:left))
        @operator = if_modifier.fetch(:operator)
        @right = ::Code::Node::Statement.new(if_modifier.fetch(:right))
      end

      def evaluate(**args)
        if operator == IF_KEYWORD
          right = @right.evaluate(**args)

          right.truthy? ? @left.evaluate(**args) : ::Code::Object::Nothing.new
        elsif operator == UNLESS_KEYWORD
          right = @right.evaluate(**args)

          right.truthy? ? ::Code::Object::Nothing.new : @left.evaluate(**args)
        elsif operator == WHILE_KEYWORD
          left = ::Code::Object::Nothing.new

          left = @left.evaluate(**args) while @right.evaluate(**args).truthy?

          left
        elsif operator == UNTIL_KEYWORD
          left = ::Code::Object::Nothing.new

          left = @left.evaluate(**args) until @right.evaluate(**args).truthy?

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
