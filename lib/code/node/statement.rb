class Code
  class Node
    class Statement < Node
      def initialize(parsed)
        if parsed.key?(:nothing)
          @statement = Node::Nothing.new(parsed.delete(:nothing))
        elsif parsed.key?(:boolean)
          @statement = Node::Boolean.new(parsed.delete(:boolean))
        end

        super(parsed)
      end

      def evaluate(**args)
        @statement.evaluate(**args)
      end
    end
  end
end
