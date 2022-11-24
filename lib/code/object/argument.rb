class Code
  class Object
    class Argument
      attr_reader :value, :name

      def initialize(value, name: nil)
        @value = value
        @name = name
      end

      def regular?
        !name
      end

      def keyword?
        !regular?
      end

      def name_value
        [name, value]
      end

      def to_s
        "<Argument #{value.inspect}>"
      end

      def inspect
        to_s
      end
    end
  end
end
