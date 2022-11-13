class Code
  class Node
    class Statement < Node
      def initialize(parsed)
        if parsed.key?(:chained_call)
          @statement =
            ::Code::Node::ChainedCall.new(parsed.delete(:chained_call))
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
        elsif parsed.key?(:splat)
          @statement = ::Code::Node::Splat.new(parsed.delete(:splat))
        elsif parsed.key?(:function)
          @statement = ::Code::Node::Function.new(parsed.delete(:function))
        elsif parsed.key?(:power)
          @statement = ::Code::Node::Power.new(parsed.delete(:power))
        elsif parsed.key?(:decimal)
          @statement = ::Code::Node::Decimal.new(parsed.delete(:decimal))
        elsif parsed.key?(:not)
          @statement = ::Code::Node::Not.new(parsed.delete(:not))
        elsif parsed.key?(:boolean)
          @statement = ::Code::Node::Boolean.new(parsed.delete(:boolean))
        elsif parsed.key?(:if)
          @statement = ::Code::Node::If.new(parsed.delete(:if))
        elsif parsed.key?(:nothing)
          @statement = ::Code::Node::Nothing.new(parsed.delete(:nothing))
        elsif parsed.key?(:rescue)
          @statement = ::Code::Node::Rescue.new(parsed.delete(:rescue))
        elsif parsed.key?(:equal)
          @statement = ::Code::Node::Equal.new(parsed.delete(:equal))
        elsif parsed.key?(:negation)
          @statement = ::Code::Node::Negation.new(parsed.delete(:negation))
        elsif parsed.key?(:dictionnary)
          @statement = ::Code::Node::Dictionnary.new(parsed.delete(:dictionnary))
        elsif parsed.key?(:list)
          @statement = ::Code::Node::List.new(parsed.delete(:list))
        elsif parsed.key?(:while)
          @statement = ::Code::Node::While.new(parsed.delete(:while))
        end

        super(parsed)
      end

      def evaluate(**args)
        @statement.evaluate(**args)
      end
    end
  end
end
