class Code
  class Node
    class Name
      def initialize(name)
        @name = name
      end

      def evaluate(context)
        context.fetch(name)
      end

      private

      attr_reader :name
    end
  end
end
