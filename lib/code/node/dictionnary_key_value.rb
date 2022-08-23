class Code
  class Node
    class DictionnaryKeyValue < Node
      def initialize(key_value)
        @key = key_value.fetch(:key)

        if @key.is_a?(Array)
          @key = ::Code::Node::Code.new(@key)
        elsif @key.key?(:name)
          @key = ::Code::Node::String.new(@key[:name])
        else
          @key = ::Code::Node::Statement.new(@key)
        end

        @value = ::Code::Node::Code.new(key_value.fetch(:value))
      end

      def evaluate(**args)
        [@key.evaluate(**args), @value.evaluate(**args)]
      end
    end
  end
end
