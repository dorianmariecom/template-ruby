class Code
  class Node
    class Nothing < Node
      def initialize
      end

      def evaluate(**args)
        ::Code::Object::Nothing.new
      end
    end
  end
end
