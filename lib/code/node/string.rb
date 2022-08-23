class Code
  class Node
    class String < Node
      def initialize(string)
        @string = string
      end

      def evaluate(context)
        ::Code::Object::String.new(string.to_s)
      end

      private

      attr_reader :string
    end
  end
end
