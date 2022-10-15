class Code
  class Node
    class StringComponent < Node
      def initialize(component)
        if component.key?(:characters)
          @component =
            ::Code::Node::StringCharacters.new(component.fetch(:characters))
        elsif component.key?(:interpolation)
          @component =
            ::Code::Node::StringInterpolation.new(
              component.fetch(:interpolation),
            )
        else
          raise NotImplementedError.new(component.inspect)
        end
      end

      def evaluate(**args)
        @component.evaluate(**args)
      end
    end
  end
end
