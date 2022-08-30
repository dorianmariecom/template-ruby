class Code
  class Node
    class Name < Node
      def initialize(name)
        @name = name
      end

      def evaluate(**args)
        context = args.fetch(:context)
        arguments = args.fetch(:arguments, [])
        object = args.fetch(:object, nil)
        io = args.fetch(:io)

        if object
          object.call(
            context: context,
            operator: name,
            arguments: arguments,
            io: io,
          )
        elsif context.key?(name)
          object = context[name]

          if object.is_a?(::Code::Object::Function)
            object.call(
              context: context,
              operator: nil,
              arguments: arguments,
              io: io,
            )
          else
            object
          end
        elsif name == "puts"
          arguments.each { |argument| io.puts argument.value }

          ::Code::Object::Nothing.new
        else
          raise ::Code::Error::Undefined.new("#{name} undefined")
        end
      end

      private

      def name
        ::Code::Object::String.new(@name.to_s)
      end
    end
  end
end
