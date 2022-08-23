class Code
  class Node
    class Name < Node
      def initialize(name)
        @name = name
      end

      def evaluate(context, arguments: [])
        if context.key?(name)
          object = context[name]

          if object.is_a?(::Code::Object::Function)
            object.call(context: context, arguments: arguments)
          else
            object
          end
        else
          context.call(context: context, operator: name, arguments: arguments)
        end
      end

      private

      def name
        ::Code::Object::String.new(@name.to_s)
      end
    end
  end
end
