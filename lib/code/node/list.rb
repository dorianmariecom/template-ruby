require "active_support"
require "active_support/core_ext/object/blank"

class Code
  class Node
    class List
      def initialize(codes)
        if codes.blank?
          @codes = []
        else
          @codes = codes.map { |code| ::Code::Node::Code.new(code[:code]) }
        end
      end

      def evaluate(context)
        ::Code::Object::List.new(@codes.map { |code| code.evaluate(context) })
      end
    end
  end
end
