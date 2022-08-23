class Code
  class Node
    class Number < Node
      def initialize(number)
        if number.key?(:base_2)
          @number = ::Code::Node::Base2Number.new(number[:base_2])
        elsif number.key?(:base_8)
          @number = ::Code::Node::Base8Number.new(number[:base_8])
        elsif number.key?(:base_10)
          @number = ::Code::Node::Base10Number.new(number[:base_10])
        elsif number.key?(:base_16)
          @number = ::Code::Node::Base16Number.new(number[:base_16])
        else
          raise NotImplementedErorr.new(number.inspect)
        end
      end

      def evaluate(context)
        @number.evaluate(context)
      end
    end
  end
end
