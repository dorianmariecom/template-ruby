class Code
  class Node
    class Base2Number
      def initialize(number)
        @number = number
      end

      def evaluate(context)
        ::Code::Object::Integer.new(number)
      end

      private

      def number
        @number.to_s.to_i(2)
      end
    end
  end
end
