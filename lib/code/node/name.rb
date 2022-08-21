class Code
  class Node
    class Name
      def initialize(name)
        @name = name
      end

      def evaluate(context, call_function: true)
        object = context.evaluate(::Code::Object::String.new(name.to_s))

        if call_function && object.is_a?(::Code::Object::Function)
          object.call(context)
        else
          object
        end
      end

      private

      attr_reader :name
    end
  end
end
