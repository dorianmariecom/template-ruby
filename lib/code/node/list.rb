class Code
  class Node
    class List < Node
      def initialize(codes)
        @codes = codes.map do |code|
          code.fetch(:code).presence && ::Code::Node::Code.new(code.fetch(:code))
        end.compact
      end

      def evaluate(**args)
        ::Code::Object::List.new(@codes.map { |code| code.evaluate(**args) })
      end
    end
  end
end
