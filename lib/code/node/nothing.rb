class Code
  class Node
    class Nothing < Node
      def initialize
      end

      def evaluate(_context)
        ::Code::Object::Nothing.new
      end
    end
  end
end
