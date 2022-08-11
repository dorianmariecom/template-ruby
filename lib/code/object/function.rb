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
            if argument.splat?
              context[argument.name] = ::Code::Object::List.new(
                call_arguments
                  .select(&:regular?)
                  .map do |call_argument|
                    call_argument.evaluate(original_context)
                  end,
              )
            elsif argument.keyword_splat?
              context[argument.name] = ::Code::Object::Dictionnary.new(
                call_arguments
                  .select(&:keyword?)
                  .map do |call_argument|
                    [
                      call_argument.name,
                      call_argument.evaluate(original_context),
                    ]
                  end
                  .to_h,
              )
            else
              call_argument = call_arguments[index]
              call_argument =
                call_argument.evaluate(original_context) if call_argument
              call_argument = argument.evaluate(context) if call_argument.nil?
              context[argument.name] = call_argument
            end
          elsif argument.keyword?
            call_argument =
              call_arguments.detect do |call_argument|
                call_argument.name == argument.name
              end

            call_argument =
              call_argument.evaluate(original_context) if call_argument
            call_argument = argument.evaluate(context) if call_argument.nil?
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
        "function"
      end

      private

      attr_reader :body, :arguments
    end
  end
end
