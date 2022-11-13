class Code
  class Node
    class Dictionnary < Node
      def initialize(parsed)
      end

      def evaluate(**args)
        ::Code::Object::Dictionnary.new
      end
    end
  end
end
