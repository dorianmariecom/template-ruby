class Code
  class Object
    class Global < ::Code::Object
      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        context = args.fetch(:context)
        io = args.fetch(:io)
        globals = multi_fetch(args, *::Code::GLOBALS)
        value = arguments.first&.value

        if operator == "print"
          io.print(*arguments.map(&:value))
          ::Code::Object::Nothing.new
        elsif operator == "puts"
          io.puts(*arguments.map(&:value))
          ::Code::Object::Nothing.new
        elsif operator == "context"
          sig(arguments) { ::Code::Object::String }
          context[value] || ::Code::Object::Nothing.new
        elsif operator == "evaluate"
          sig(arguments) { ::Code::Object::String }
          Code.evaluate(value.raw)
        else
          result = context[operator]

          if result && result.is_a?(::Code::Object::Function)
            result.call(**args.merge(operator: nil))
          elsif result
            result
          else
            raise ::Code::Error::Undefined.new("#{operator} is not defined")
          end
        end
      end

      def to_s
        "global"
      end
    end
  end
end
