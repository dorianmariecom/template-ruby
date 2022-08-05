class Code
  class Node
    class Defined
      def initialize(defined)
        @name = defined.fetch(:name)
      end

      def evaluate(context)
        ::Code::Object::Boolean.new(context.key?(name))
      end

      private

      def name
        ::Code::Object::String.new(@name.to_s)
      end
    end
  end
end
