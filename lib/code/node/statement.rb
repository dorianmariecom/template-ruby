class Code
  class Node
    class Statement < Node
      def initialize(parsed)
        if parsed.key?(:chained_call)
          @statement = ::Code::Node::ChainedCall.new(parsed.delete(:chained_call))
        elsif parsed.key?(:group)
          @statement = ::Code::Node::Code.new(parsed.delete(:group))
        elsif parsed.key?(:operation)
          @statement = ::Code::Node::Operation.new(parsed.delete(:operation))
        elsif parsed.key?(:integer)
          @statement = ::Code::Node::Integer.new(parsed.delete(:integer))
        elsif parsed.key?(:call)
          @statement = ::Code::Node::Call.new(parsed.delete(:call))
        elsif parsed.key?(:string)
          @statement = ::Code::Node::String.new(parsed.delete(:string))
        end

        super(parsed)
      end

      def evaluate(**args)
        @statement.evaluate(**args.merge(object: ::Code::Object::Global.new))
      end
    end
  end
end
