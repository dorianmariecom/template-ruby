class Code
  class Node
    class Operator < Node
      attr_reader :statement, :operator

      def initialize(parsed)
        @statement = ::Code::Node::Statement.new(parsed.delete(:statement))
        @operator = parsed.delete(:operator)
        super(parsed)
      end
    end
  end
end
