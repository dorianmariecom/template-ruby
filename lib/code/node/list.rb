class Code
  class Node
    class List < Node
      def initialize(codes)
        if codes.to_s.blank?
          @codes = []
        else
          @codes =
            codes.map { |code| ::Code::Node::Code.new(code.fetch(:code)) }
        end
      end

      def evaluate(**args)
        ::Code::Object::List.new(@codes.map { |code| code.evaluate(**args) })
      end
    end
  end
end
