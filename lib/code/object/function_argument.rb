class Code
  class Object
    class FunctionArgument
      attr_reader :node, :default, :name, :splat, :keyword_splat

      def initialize(node, default: nil, name: nil, splat: false, keyword_splat: false)
        @node = node
        @default = default
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
