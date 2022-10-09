class Code
  class Node
    class String < Node
      def initialize(string)
        if string.to_s.blank?
          @string = []
        elsif string.is_a?(Array)
          @string = string.map do |component|
            ::Code::Node::StringComponent.new(component)
          end
        else
          @string = [::Code::Node::StringCharacters.new(string)]
        end
      end

      def evaluate(**args)
        string = @string.map { |component| component.evaluate(**args) }.map(&:to_s).join
        ::Code::Object::String.new(string)
      end
    end
  end
end
