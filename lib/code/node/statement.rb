class Code
  class Node
    class Statement < Node
      def initialize(parsed)
        if parsed.key?(:nothing)
          @statement = Node::Nothing.new(parsed.delete(:nothing))
        elsif parsed.key?(:boolean)
          @statement = Node::Boolean.new(parsed.delete(:boolean))
        elsif parsed.key?(:group)
          @statement = Node::Code.new(parsed.delete(:group))
        elsif parsed.key?(:call)
          @statement = Node::Call.new(parsed.delete(:call))
        elsif parsed.key?(:number)
          @statement = Node::Number.new(parsed.delete(:number))
        elsif parsed.key?(:string)
          @statement = Node::String.new(parsed.delete(:string))
        elsif parsed.key?(:list)
          @statement = Node::List.new(parsed.delete(:list))
        elsif parsed.key?(:dictionnary)
          @statement = Node::Dictionnary.new(parsed.delete(:dictionnary))
        elsif parsed.key?(:chained_call)
          @statement = Node::ChainedCall.new(parsed.delete(:chained_call))
        elsif parsed.key?(:operation)
          @statement = Node::Operation.new(parsed.delete(:operation))
        elsif parsed.key?(:equal)
          @statement = Node::Equal.new(parsed.delete(:equal))
        elsif parsed.key?(:function)
          @statement = Node::Function.new(parsed.delete(:function))
        elsif parsed.key?(:negation)
          @statement = Node::Negation.new(parsed.delete(:negation))
        elsif parsed.key?(:power)
          @statement = Node::Power.new(parsed.delete(:power))
        elsif parsed.key?(:unary_minus)
          @statement = Node::UnaryMinus.new(parsed.delete(:unary_minus))
        elsif parsed.key?(:ternary)
          @statement = Node::Ternary.new(parsed.delete(:ternary))
        elsif parsed.key?(:rescue)
          @statement = Node::Rescue.new(parsed.delete(:rescue))
        elsif parsed.key?(:not)
          @statement = Node::Not.new(parsed.delete(:not))
        elsif parsed.key?(:if_modifier)
          @statement = Node::IfModifier.new(parsed.delete(:if_modifier))
        elsif parsed.key?(:if)
          @statement = Node::If.new(parsed.delete(:if))
        elsif parsed.key?(:while)
          @statement = Node::While.new(parsed.delete(:while))
        elsif parsed.key?(:splat)
          @statement = Node::Splat.new(parsed.delete(:splat))
        end

        super(parsed)
      end

      def evaluate(**args)
        @statement.evaluate(**args)
      end
    end
  end
end
