class Code
  class Node
    class Identifier < Node
      def initialize(parsed)
        if parsed.key?(:name)
          @identifier = ::Code::Node::Name.new(parsed.delete(:name))
        elsif parsed.key?(:block)
          @identifier = ::Code::Node::Block.new(parsed.delete(:block))
        end

        super(parsed)
      end
    end
  end
end
