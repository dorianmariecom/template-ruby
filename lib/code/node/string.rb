class Code
  class Node
    class String
      def initialize(string)
        @string = string
      end

      def evaluate(context)
        ::Code::Object::String.new(string)
      end

      private

      attr_reader :string
    end
  end
end
