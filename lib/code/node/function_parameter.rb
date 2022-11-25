class Code
  class Node
    class FunctionParameter < Node
      def initialize(parsed)
        @name = parsed.delete(:name)
        @keyword = !!parsed.delete(:keyword)
        super(parsed)
      end

      def name
        ::Code::Object::String.new(@name)
      end

      def regular?
        !@keyword
      end

      def keyword?
        !!@keyword
      end

      def regular_splat?
        false
      end

      def keyword_splat?
        false
      end
    end
  end
end
