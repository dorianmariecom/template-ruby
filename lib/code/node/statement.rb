class Code
  class Node
    class Statement
      def initialize(statement)
        if statement.key?(:nothing)
          @statement = ::Code::Node::Nothing.new
        elsif statement.key?(:boolean)
          @statement = ::Code::Node::Boolean.new(statement[:boolean])
        elsif statement.key?(:number)
          @statement = ::Code::Node::Number.new(statement[:number])
        elsif statement.key?(:string)
          @statement = ::Code::Node::String.new(statement[:string])
        elsif statement.key?(:call)
          @statement = ::Code::Node::Call.new(statement[:call])
        elsif statement.key?(:name)
          @statement = ::Code::Node::Name.new(statement[:name])
        elsif statement.key?(:list)
          @statement = ::Code::Node::List.new(statement[:list])
        elsif statement.key?(:dictionnary)
          @statement = ::Code::Node::Dictionnary.new(statement[:dictionnary])
        elsif statement.key?(:unary)
          @statement = ::Code::Node::Unary.new(statement[:unary])
        else
          raise NotImplementedError.new(statement.inspect)
        end
      end

      def evaluate(context)
        @statement.evaluate(context)
      end
    end
  end
end