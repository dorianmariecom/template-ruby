class Code
  class Node
    class StringInterpolation < Node
      def initialize(interpolation)
        @interpolation = ::Code::Node::Code.new(interpolation)
      end

      def evaluate(**args)
        @interpolation.evaluate(**args)
      end
    end
  end
end
