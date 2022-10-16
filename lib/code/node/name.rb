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
        io = args.fetch(:io)

        object.call(
          context: context,
          operator: name,
          arguments: arguments,
          io: io,
          object: object
        )
      end

      private

      def name
        ::Code::Object::String.new(@name.to_s)
      end
    end
  end
end
