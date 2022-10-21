class Code
  class Object
    class RubyFunction < ::Code::Object::Function
      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

      private

      def call_function(args:, globals:)
        regular_arguments = args.select(&:regular?).map(&:value).map do |argument|
          ::Code::Ruby.from_code(argument)
        end

        keyword_arguments = args.select(&:keyword?).map do |argument|
          [argument.name.to_sym, ::Code::Ruby.from_code(argument.value)]
        end.to_h

        ::Code::Ruby.to_code(raw.call(*regular_arguments, **keyword_arguments))
      end
    end
  end
end
