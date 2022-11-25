class Code
  class Node
    class Decimal < Node
      def initialize(parsed)
        @decimal = parsed
      end

      def evaluate(**args)
        ::Code::Object::Decimal.new(@decimal)
      end
    end
  end
end
