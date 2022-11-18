class Code
  class Node
    class Dictionnary < Node
      class KeyValue < Node
        def initialize(parsed)
          if parsed.key?(:name)
            if parsed[:name].is_a?(::String)
              @name = ::Code::Node::String.new(parsed.delete(:name))
            elsif parsed[:name].key?(:string)
              @name = ::Code::Node::String.new(parsed.delete(:name).delete(:string))
            else
              raise NotImplementedError.new(parsed)
            end
          end

          if parsed.key?(:value)
            @value = ::Code::Node::Code.new(parsed.delete(:value))
          end

          super(parsed)
        end

        def evaluate(**args)
          [@name.evaluate(**args), @value.evaluate(**args)]
        end
      end

      def initialize(parsed)
        @key_values = parsed.map do |key_value|
          ::Code::Node::Dictionnary::KeyValue.new(key_value)
        end
      end

      def evaluate(**args)
        ::Code::Object::Dictionnary.new(
          @key_values.map do |key_value|
            key_value.evaluate(**args)
          end.to_h
        )
      end
    end
  end
end
