class Code
  class Node
    class Equal < Node
      def initialize(equal)
        @left = equal.fetch(:left).fetch(:name)
        @operator = equal.fetch(:operator)
        @right = ::Code::Node::Statement.new(equal.fetch(:right))
      end

      def evaluate(context)
        right = @right.evaluate(context)

        if operator
          if context[left]
            context[left] = simple_call(context[left], operator, right)
          else
            raise ::Code::Error::UndefinedVariable.new("#{left} is undefined")
          end
        else
          context[left] = right
        end
      end

      private

      def operator
        @operator.to_s[0...-1].to_sym.presence
      end

      def left
        ::Code::Object::String.new(@left.to_s)
      end
    end
  end
end
