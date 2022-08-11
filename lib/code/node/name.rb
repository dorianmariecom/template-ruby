class Code
  class Node
    class Name
      def initialize(name)
        @name = name
      end

      def evaluate(context, call_function: true)
        result = context.evaluate(::Code::Object::String.new(name.to_s))

        if result.is_a?(::Code::Object::Function) && call_function
          result.call(context)
        else
          result
        end
      end

      private

      attr_reader :name
    end
  end
end
