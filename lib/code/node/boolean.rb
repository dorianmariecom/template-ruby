class Code
  class Node
    class Boolean
      def initialize(boolean)
        @boolean = boolean == "true" ? true : false
      end

      def evaluate(_context)
        ::Code::Object::Boolean.new(@boolean)
      end
    end
  end
end
