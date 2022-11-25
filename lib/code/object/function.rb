class Code
  class Object
    class Function < ::Code::Object
      def initialize(parameters:, body:)
        @parameters = parameters
        @body = body
      end

      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        globals = multi_fetch(args, *::Code::GLOBALS)

        if operator.nil? || operator == "call"
          call_function(args: arguments, globals: globals)
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

      attr_reader :parameters, :body

      def call_function(args:, globals:)
        new_context = deep_dup(globals[:context])

        parameters.each.with_index do |parameter, index|
          if parameter.regular?
            if parameter.regular_splat?
              new_context[parameter.name] = ::Code::Object::List.new(
                args.select(&:regular?).map(&:value)
              )
            elsif parameter.keyword_splat?
              new_context[parameter.name] = ::Code::Object::Dictionnary.new(
                args.select(&:keyword?).map(&:name_value).to_h
              )
            else
              arg = args[index]&.value
              arg = parameter.evaluate(**globals) if arg.nil?
              new_context[parameter.name] = arg
            end
          elsif parameter.keyword?
            arg = args.detect { |arg| arg.name == parameter.name }&.value
            arg = parameter.evaluate(**globals) if arg.nil?
            new_context[parameter.name] = arg
          else
            raise NotImplementedError
          end
        end

        body.evaluate(**globals, context: new_context)
      end
    end
  end
end
