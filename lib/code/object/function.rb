class Code
  class Object
    class Function < ::Code::Object
      def initialize(arguments: [], body:)
        @arguments = arguments
        @body = body
      end

      def call(context, *args)
        context = context.dup
        arguments.each.with_index do |argument, index|
          context[argument.name] = args.fetch(index) { ::Code::Object::Nothing.new }
        end
        body.evaluate(context)
      end

      def to_s
        ""
      end

      def inspect
        to_s
      end

      private

      attr_reader :body, :arguments
    end
  end
end
