class Code
  class Node
    class Statement < Node
      def initialize(parsed)
        if parsed.key?(:nothing)
          @statement = Nothing.new(parsed.delete(:nothing))
        end

        super(parsed)
      end

      def evaluate(**args)
        @statement.evaluate(**args)
      end
    end
  end
end
