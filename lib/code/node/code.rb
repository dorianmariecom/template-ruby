class Code
  class Node
    class Code
      def initialize(parsed)
        @statements = parsed.map do |statement|
          Statement.new(statement)
        end
      end

      def evaluate(**args)
        last = ::Code::Object::Nothing.new

        @statements.each do |statement|
          last = statement.evaluate(**args)
        end

        last
      end
    end
  end
end
