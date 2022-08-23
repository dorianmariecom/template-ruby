class Code
  class Node
    class Dictionnary < Node
      def initialize(key_values)
        if key_values.blank?
          @key_values = []
        else
          @key_values =
            key_values.map do |key_value|
              ::Code::Node::DictionnaryKeyValue.new(key_value)
            end
        end
      end

      def evaluate(context)
        ::Code::Object::Dictionnary.new(
          @key_values.map { |key_value| key_value.evaluate(context) }.to_h,
        )
      end
    end
  end
end
