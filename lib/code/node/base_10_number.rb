class Code
  class Node
    class Base10Number < Node
      def initialize(number)
        if number.key?(:integer)
          @number = ::Code::Node::Base10Integer.new(number[:integer])
        elsif number.key?(:decimal)
          @number = ::Code::Node::Base10Decimal.new(number[:decimal])
        else
          raise NotImplementedErorr.new(number.inspect)
        end
      end

      def evaluate(**args)
        @number.evaluate(**args)
      end
    end
  end
end
