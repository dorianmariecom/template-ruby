class Code
  class Node
    class If
      IF_KEYWORD = "if"
      UNLESS_KEYWORD = "unless"

      class Else
        def initialize(else_parsed)
          if else_parsed.key?(:operator)
            @operator = else_parsed.fetch(:operator)
            @statement =
              ::Code::Node::Statement.new(else_parsed.fetch(:statement))
          end

          @body = ::Code::Node::Code.new(else_parsed.fetch(:body))
        end

        attr_reader :operator, :body, :statement
      end

      def initialize(if_parsed)
        @if_operator = if_parsed.fetch(:if_operator)
        @if_statement =
          ::Code::Node::Statement.new(if_parsed.fetch(:if_statement))
        @if_body = ::Code::Node::Code.new(if_parsed.fetch(:if_body))
        @elses = if_parsed.fetch(:elses, [])
        @elses.map! { |else_parsed| ::Code::Node::If::Else.new(else_parsed) }
      end

      def evaluate(context)
        if_object = @if_statement.evaluate(context)

        if @if_operator == IF_KEYWORD && if_object.truthy?
          @if_body.evaluate(context)
        elsif @if_operator == UNLESS_KEYWORD && if_object.falsy?
          @if_body.evaluate(context)
        else
          @elses.each do |else_node|
            if else_node.operator == IF_KEYWORD
              else_object = else_node.statement.evaluate(context)
              return else_node.body.evaluate(context) if else_object.truthy?
            elsif else_node.operator == UNLESS_KEYWORD
              else_object = else_node.statement.evaluate(context)
              return else_node.body.evaluate(context) if else_object.falsy?
            elsif else_node.operator.nil?
              return else_node.body.evaluate(context)
            end
          end

          ::Code::Object::Nothing.new
        end
      end
    end
  end
end
