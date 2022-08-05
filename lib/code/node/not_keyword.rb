class Code
  class Node
    class NotKeyword
      def initialize(not_keyword)
        @statement = ::Code::Node::Statement.new(not_keyword)
      end

      def evaluate(context)
        ::Code::Object::Boolean.new(!@statement.evaluate(context).truthy?)
      end
    end
  end
end
