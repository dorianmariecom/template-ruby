class Code
  class Node
    class Statement < Node
      def initialize(parsed)
        if parsed.key?(:nothing)
          @statement = Node::Nothing.new(parsed.delete(:nothing))
        elsif parsed.key?(:boolean)
          @statement = Node::Boolean.new(parsed.delete(:boolean))
        elsif parsed.key?(:group)
          @statement = Node::Code.new(parsed.delete(:group))
        elsif parsed.key?(:call)
          @statement = Node::Call.new(parsed.delete(:call))
        elsif parsed.key?(:number)
          @statement = Node::Number.new(parsed.delete(:number))
        end

        super(parsed)
      end

      def evaluate(**args)
        @statement.evaluate(**args)
      end
    end
  end
end
