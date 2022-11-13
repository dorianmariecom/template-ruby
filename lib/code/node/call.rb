class Code
  class Node
    class Call < Node
      def initialize(parsed)
        @name = parsed.delete(:name)

        if parsed[:arguments]
          @arguments = parsed.delete(:arguments).map do |call_argument|
            ::Code::Node::CallArgument.new(call_argument)
          end
        else
          @arguments = nil
        end
        super(parsed)
      end

      def evaluate(**args)
        object = args.fetch(:object)

        if @arguments.nil?
          object.call(**args, operator: @name)
        else
          raise NotImplementedError
        end
      end
    end
  end
end
