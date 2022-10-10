class Code
  class Object
    class Function < ::Code::Object
      def initialize(arguments:, body:)
        @arguments = arguments
        @body = body
      end

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        context = args.fetch(:context)
        io = args.fetch(:io)

        if operator.nil?
          call_function(args: arguments, context: context, io: io)
        else
          super
        end
      end

      def to_s
        ""
      end

      def inspect
        "function"
      end

      private

      attr_reader :arguments, :body

      def call_function(args:, context:, io:)
        new_context = context.deep_dup

        arguments.each.with_index do |argument, index|
          if argument.regular?
            if argument.splat?
              new_context[argument.name] = ::Code::Object::List.new(
                args.select(&:regular?).map(&:value),
              )
            elsif argument.keyword_splat?
              new_context[argument.name] = ::Code::Object::Dictionnary.new(
                args.select(&:keyword?).map(&:name_value).to_h,
              )
            else
              arg = args[index]&.value
              arg = argument.evaluate(context: new_context, io: io) if arg.nil?
              new_context[argument.name] = arg
            end
          elsif argument.keyword?
            arg = args.detect { |arg| arg.name == argument.name }&.value
            arg = argument.evaluate(context: new_context, io: io) if arg.nil?
            new_context[argument.name] = arg
          else
            raise NotImplementedError
          end
        end

        body.evaluate(context: new_context, io: io)
      end
    end
  end
end
