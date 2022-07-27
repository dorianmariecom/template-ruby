class Code
  class Node
    class Dictionnary
      def initialize(key_values)
        @key_values =
          key_values.map do |key_value|
            ::Code::Node::DictionnaryKeyValue.new(key_value)
          end
      end

      def evaluate(context)
        ::Code::Object::Dictionnary.new(
          @key_values.map { |key_value| key_value.evaluate(context) }.to_h
        )
      end
    end
  end
end
