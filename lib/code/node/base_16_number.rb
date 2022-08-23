class Code
  class Node
    class Base16Number < Node
      def initialize(number)
        @number = number
      end

      def evaluate(**args)
        ::Code::Object::Integer.new(number)
      end

      private

      def number
        @number.to_s.to_i(16)
      end
    end
  end
end
