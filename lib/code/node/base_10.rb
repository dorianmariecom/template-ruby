class Code
  class Node
    class Base10 < Node
      def initialize(parsed)
        @base_10 = parsed
      end

      def evaluate(**args)
        ::Code::Object::Integer.new(@base_10.to_i)
      end
    end
  end
end
