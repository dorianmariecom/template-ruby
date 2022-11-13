class Code
  class Node
    class Nothing < Node
      def initialize(parsed)
      end

      def evaluate(**args)
        ::Code::Object::Nothing.new
      end
    end
  end
end
