class Code
  class Node
    class Number < Node
      def initialize(parsed)
        if parsed.key?(:decimal)
          @statement = Node::Decimal.new(parsed.delete(:decimal))
        elsif parsed.key?(:base_16)
          @statement = Node::Base16.new(parsed.delete(:base_16))
        elsif parsed.key?(:base_10)
          @statement = Node::Base10.new(parsed.delete(:base_10))
        elsif parsed.key?(:base_8)
          @statement = Node::Base8.new(parsed.delete(:base_8))
        elsif parsed.key?(:base_2)
          @statement = Node::Base2.new(parsed.delete(:base_2))
        end

        super(parsed)
      end

      def evaluate(**args)
        @statement.evaluate(**args)
      end
    end
  end
end
