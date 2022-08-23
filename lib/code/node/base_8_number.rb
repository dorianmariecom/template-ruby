class Code
  class Node
    class Base8Number < Node
      def initialize(number)
        @number = number
      end

      def evaluate(context)
        ::Code::Object::Integer.new(number)
      end

      private

      def number
        @number.to_s.to_i(8)
      end
    end
  end
end
