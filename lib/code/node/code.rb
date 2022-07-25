require "active_support"
require "active_support/core_ext/object/blank"

class Code
  class Node
    class Code
      def initialize(statements)
        statements = [] if statements.blank?

        @statements = statements.map do |statement|
          ::Code::Node::Statement.new(statement)
        end
      end

      def evaluate(context)
        @statements.reduce(context) do |context, statement|
          statement.evaluate(context)
        end
      end
    end
  end
end
