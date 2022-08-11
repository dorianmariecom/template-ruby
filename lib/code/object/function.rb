class Code
  class Object
    class Function < ::Code::Object
      def initialize(arguments: [], body:)
        @arguments = arguments
        @body = body
      end

      def call(original_context, call_arguments = [])
        context = original_context.dup
        arguments.each.with_index do |argument, index|
          if argument.regular?
            call_argument = call_arguments[index]&.evaluate(original_context)
            call_argument ||= ::Code::Object::Nothing.new
            context[argument.name] = call_argument
          elsif argument.keyword?
            call_argument = call_arguments.detect { |arg| arg.name == argument.name }
            call_argument = call_argument.evaluate(original_context) if call_argument
            call_argument ||= ::Code::Object::Nothing.new
            context[argument.name] = call_argument
          else
            raise NotImplementedError
          end
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
