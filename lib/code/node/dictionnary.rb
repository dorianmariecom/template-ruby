class Code
  class Node
    class Dictionnary < Node
      class KeyValue < Node
        def initialize(parsed)
          if parsed.key?(:statement)
            @key = Node::Statement.new(parsed.delete(:statement))
          elsif parsed.key?(:name)
            @key = Node::String.new([{ text: parsed.delete(:name) }])
          end

          @value = Node::Code.new(parsed.delete(:value))
        end

        def evaluate(**args)
          [@key.evaluate(**args), @value.evaluate(**args)]
        end
      end

      def initialize(parsed)
        parsed = [] if parsed == ""
        @key_values = parsed.map do |key_value|
          Node::Dictionnary::KeyValue.new(key_value)
        end
      end

      def evaluate(**args)
        ::Code::Object::Dictionnary.new(
          @key_values.map { |key_value| key_value.evaluate(**args) }.to_h,
        )
      end
    end
  end
end
