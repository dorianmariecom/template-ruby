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
        end

        super(parsed)
      end

      def evaluate(**args)
        @statement.evaluate(**args)
      end
    end
  end
end
