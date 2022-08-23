class Code
  class Object
    class List < ::Code::Object
      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

      def call(arguments: [], context: ::Code::Object::Context.new, operator: nil)
        if operator == "any?"
          any?(arguments)
        elsif operator == "first"
          first(arguments)
        elsif operator == "last"
          last(arguments)
        else
          super
        end
      end

      def map(&block)
        @raw = raw.map(&block)
        self
      end

      def join
        raw.join
      end

      def to_s
        "[#{raw.map(&:inspect).join(", ")}]"
      end

      def inspect
        to_s
      end

      private

      def any?(arguments)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first
        ::Code::Object::Boolean.new(
          raw.any? do |element|
            simple_call(argument.value, nil, element).truthy?
          end
        )
      end

      def first(arguments)
        sig(arguments)
        raw.first
      end

      def last(arguments)
        sig(arguments)
        raw.last
      end
    end
  end
end
