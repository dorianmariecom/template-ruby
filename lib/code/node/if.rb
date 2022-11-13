class Code
  class Node
    class If < Node
      IF_KEYWORD = ::Code::Parser::IF_KEYWORD
      UNLESS_KEYWORD = ::Code::Parser::UNLESS_KEYWORD

      class Other < Node
        attr_reader :operator, :condition, :body

        def initialize(parsed)
          @operator = parsed.delete(:operator)
          @condition = ::Code::Node::Statement.new(parsed.delete(:condition))
          @body = ::Code::Node::Code.new(parsed.delete(:body))
        end
      end

      def initialize(parsed)
        @first_operator = parsed.delete(:first_operator)
        @first_condition = ::Code::Node::Statement.new(parsed.delete(:first_condition))
        @first_body = ::Code::Node::Code.new(parsed.delete(:first_body))
        @others = (parsed.delete(:others) || []).map do |other|
          ::Code::Node::If::Other.new(other)
        end

        super(parsed)
      end

      def evaluate(**args)
        first_condition = @first_condition.evaluate(**args)

        if @first_operator == IF_KEYWORD && first_condition.truthy?
          @first_body.evaluate(**args)
        elsif @first_operator == UNLESS_KEYWORD && first_condition.falsy?
          @first_body.evaluate(**args)
        else
          @others.each do |other|
            condition = other.condition.evaluate(**args)

            if other.operator == IF_KEYWORD && condition.truthy?
              return other.body.evaluate(**args)
            elsif other.operator == UNLESS_KEYWORD && condition.falsy?
              return other.body.evaluate(**args)
            end
          end
          ::Code::Object::Nothing.new
        end
      end
    end
  end
end
