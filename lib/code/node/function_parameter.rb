class Code
  class Node
    class FunctionParameter < Node
      attr_reader :name

      def initialize(parsed)
        @name = parsed.delete(:name)

        super(parsed)
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
