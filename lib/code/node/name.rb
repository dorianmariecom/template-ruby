class Code
  class Node
    class Name < Node
      def initialize(name)
        @name = name
      end

      def evaluate(**args)
        context = args.fetch(:context)
        arguments = args.fetch(:arguments, [])
        object = args.fetch(:object)
        globals = args.multi_fetch(*::Code::GLOBALS)

        object.call(
          operator: name,
          arguments: arguments,
          **globals
        )
      end

      private

      def name
        ::Code::Object::String.new(@name.to_s)
      end
    end
  end
end
