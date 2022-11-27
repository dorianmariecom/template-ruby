class Code
  class Node
    class Code < Node
      def initialize(parsed)
        @statements = parsed.map { |statement| Node::Statement.new(statement) }
      end

      def evaluate(**args)
        last = ::Code::Object::Nothing.new

        @statements.each do |statement|
          last =
            statement.evaluate(**args.merge(object: ::Code::Object::Global.new))
        end

        last
      end
    end
  end
end
