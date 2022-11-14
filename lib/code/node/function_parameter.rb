class Code
  class Node
    class FunctionParameter < Node
      def initialize(parsed)
        @name = parsed.delete(:name)

        super(parsed)
      end

      def name
        ::Code::Object::String.new(@name)
      end

      def regular?
        true
      end

      def splat?
        false
      end

      def keyword_splat?
        false
      end
    end
  end
end
