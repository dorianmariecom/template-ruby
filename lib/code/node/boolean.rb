class Code
  class Node
    class Boolean < Node
      TRUE = "true"
      FALSE = "false"

      def initialize(boolean)
        @boolean = boolean
      end

      def evaluate(**args)
        if @boolean == TRUE
          ::Code::Object::Boolean.new(true)
        elsif @boolean == FALSE
          ::Code::Object::Boolean.new(false)
        else
          raise NotImplementedError, @boolean.inspect
        end
      end
    end
  end
end
