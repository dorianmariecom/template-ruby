class Code
  class Object
    class CallArgument
      attr_reader :value, :name, :splat, :keyword_splat

      def initialize(value, name: nil, splat: false, keyword_splat: false)
        @value = value
        @name = name
        @splat = !!splat
        @keyword_splat = !!keyword_splat
      end

      def regular?
        !keyword?
      end

      def keyword?
        !!name
      end
    end
  end
end
