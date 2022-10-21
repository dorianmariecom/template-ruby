class Code
  class Object
    class Global < ::Code::Object
      def call(**args)
        operator = args.fetch(:operator, nil)
        arguments = args.fetch(:arguments, [])
        context = args.fetch(:context)
        io = args.fetch(:io)
        globals = args.multi_fetch(*::Code::GLOBALS)

        if operator == "print"
          io.print(*arguments.map(&:value))
          ::Code::Object::Nothing.new
        elsif operator == "puts"
          io.puts(*arguments.map(&:value))
          ::Code::Object::Nothing.new
        elsif operator == "context"
          sig(arguments, ::Code::Object::String)
          context[arguments.first.value] || ::Code::Object::Nothing.new
        elsif operator == "eval"
          sig(arguments, ::Code::Object::String)
          Code.evaluate(arguments.first.value.raw)
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
    end
  end
end
