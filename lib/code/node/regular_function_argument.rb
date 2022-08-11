class Code
  class Node
    class RegularFunctionArgument
      def initialize(argument)
        @name = argument.fetch(:name)
      end

      def evaluate(context)
        raise NotImplementedError
      end

      def name
        ::Code::Object::String.new(@name.to_s)
      end
    end
  end
end
