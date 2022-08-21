class Code
  class Node
    class Name
      def initialize(name)
        @name = name
      end

      def evaluate(context)
        context.evaluate(::Code::Object::String.new(name.to_s))
      end

      private

      attr_reader :name
    end
  end
end
