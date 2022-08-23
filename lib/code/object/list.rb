class Code
  class Object
    class List < ::Code::Object
      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

      def call(arguments: [], context: ::Code::Object::Context.new, operator: nil)
        if operator == "any?"
          any?(arguments, context)
        elsif operator == "first"
          first(arguments)
        elsif operator == "last"
          last(arguments)
        elsif operator == "max_by"
          max_by(arguments, context)
        elsif operator == "<<"
          append(arguments)
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

      def any?(arguments, context)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first
        ::Code::Object::Boolean.new(
          raw.any? do |element|
            argument.value.call(
              arguments: [::Code::Object::Argument.new(element)],
              context: context
            ).truthy?
          end
        )
      end

      def max_by(arguments, context)
        sig(arguments, ::Code::Object::Function)
        argument = arguments.first
        raw.max_by do |element|
          argument.value.call(
            arguments: [::Code::Object::Argument.new(element)],
            context: context
          )
        end || ::Code::Object::Nothing.new
      end

      def append(arguments)
        sig(arguments, ::Code::Object)
        raw << arguments.first.value
        self
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
