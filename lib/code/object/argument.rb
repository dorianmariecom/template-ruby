class Code
  class Object
    class Argument < ::Code::Object
      attr_reader :value, :name, :splat, :keyword_splat, :block

      def initialize(value, name: nil, splat: false, keyword_splat: false, block: false)
        @value = value
        @name = name
        @splat = !!splat
        @keyword_splat = !!keyword_splat
        @block = !!block
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
        "argument"
      end

      def inspect
        to_s
      end
    end
  end
end
