class Code
  class Node
    class String < Node
      class Part < Node
        class Code < Node
          def initialize(parsed)
            @code = Node::Code.new(parsed)
          end

          def evaluate(**args)
            @code.evaluate(**args)
          end
        end

        class Text < Node
          def initialize(parsed)
            @text = parsed
          end

          def evaluate(**args)
            ::Code::Object::String.new(@text)
          end
        end

        def initialize(parsed)
          if parsed.key?(:text)
            @part = Node::String::Part::Text.new(parsed.delete(:text))
          elsif parsed.key?(:code)
            @part = Node::String::Part::Code.new(parsed.delete(:code))
          end

          super(parsed)
        end

        def evaluate(**args)
          @part.evaluate(**args)
        end
      end

      def initialize(parsed)
        parsed = [] if parsed == ""

        @parts = parsed.map { |part| Node::String::Part.new(part) }
      end

      def evaluate(**args)
        ::Code::Object::String.new(
          @parts.map { |part| part.evaluate(**args) }.map(&:to_s).join
        )
      end
    end
  end
end
