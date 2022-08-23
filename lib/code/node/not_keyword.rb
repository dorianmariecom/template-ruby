class Code
  class Node
    class NotKeyword < Node
      def initialize(not_keyword)
        @statement = ::Code::Node::Statement.new(not_keyword)
      end

      def evaluate(**args)
        ::Code::Object::Boolean.new(!@statement.evaluate(**args).truthy?)
      end
    end
  end
end
