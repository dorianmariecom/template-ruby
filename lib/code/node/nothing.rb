class Code
  class Node
    class Nothing
      def initialize
      end

      def evaluate(_context)
        ::Code::Object::Nothing.new
      end
    end
  end
end
