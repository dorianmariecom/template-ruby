class Language
  class Atom
    class Rule < Atom
      def initialize(name:)
        @name = name
      end

      def parse(parser)
        parser.find_rule!(@name).parse(parser)
      end

      def to_s
        "rule(#{@name.inspect})"
      end
    end

    class Any < Atom
      def parse(parser)
        parser.consume(1)
      end

      def to_s
        "any"
      end
    end

    class Then < Atom
      def initialize(parent:, block:)
        @parent = parent
        @block = block
      end

      def parse(parser)
        @parent.parse(parser)
        parser.output = Output.from_raw(@block.call(parser.output.to_raw))
      end

      def to_s
        "(#{@parent}).then {}"
      end
    end

    class Repeat < Atom
      def initialize(parent: nil, min: 0, max: nil)
        @parent = parent
        @min = min
        @max = max
      end

      def parse(parser)
        return unless @parent

        if @max.nil?
          @min.times { match(parser) }

          begin
            loop { match(parser) }
          rescue Parser::Interuption
          end
        else
          begin
            (@min...@max).each { match(parser) }
          rescue Parser::Interuption
          end
        end
      end

      def to_s
        min = @min.zero? ? "" : @min.to_s
        max = @max.nil? ? "" : ", #{@max}"
        parenthesis = min.empty? && max.empty? ? "" : "(#{min}#{max})"

        @parent ? "(#{@parent}).repeat#{parenthesis}" : "repeat#{parenthesis}"
      end

      private

      def match(parser)
        clone =
          Parser.new(
            root: self,
            input: parser.input,
            cursor: parser.cursor,
            buffer: parser.buffer,
          )

        @parent.parse(clone)

        parser.cursor = clone.cursor
        parser.buffer = clone.buffer
        parser.output << clone.output
      end
    end

    class Str < Atom
      def initialize(string:)
        @string = string
      end

      def parse(parser)
        if parser.next?(@string)
          parser.consume(@string.size)
        else
          raise Parser::Str::NotFound.new(parser, @string)
        end
      end

      def to_s
        "str(#{@string.inspect})"
      end
    end

    class Absent < Atom
      def initialize(parent: nil)
        @parent = parent
      end

      def parse(parser)
        clone =
          Parser.new(
            root: self,
            input: parser.input,
            cursor: parser.cursor,
            buffer: parser.buffer,
          )
        @parent.parse(clone) if @parent
      rescue Parser::Interuption
      else
        raise Parser::Interuption.new(parser, self)
      end

      def to_s
        @parent ? "(#{@parent}).absent" : "absent"
      end
    end

    class Ignore < Atom
      def initialize(parent: nil)
        @parent = parent
      end

      def parse(parser)
        clone =
          Parser.new(
            root: self,
            input: parser.input,
            cursor: parser.cursor,
            buffer: parser.buffer,
          )
        @parent.parse(clone) if @parent
        parser.cursor = clone.cursor
      end

      def to_s
        @parent ? "#{@parent}.ignore" : "ignore"
      end
    end

    class Maybe < Atom
      def initialize(parent:)
        @parent = parent
      end

      def parse(parser)
        @parent.parse(parser)
      rescue Parser::Interuption
      end

      def to_s
        @parent ? "#{@parent}.maybe" : "maybe"
      end
    end

    class Aka < Atom
      def initialize(name:, parent:)
        @name = name
        @parent = parent
      end

      def parse(parser)
        clone =
          Parser.new(root: self, input: parser.input, cursor: parser.cursor)

        @parent.parse(clone)

        if clone.output?
          parser.output = Output.new(@name => clone.output)
        else
          parser.output[@name] = Output.new(clone.buffer)
          parser.buffer = ""
        end

        parser.cursor = clone.cursor
      end

      def to_s
        @parent ? "#{@parent}.aka(#{@name.inspect})" : "aka(#{@name.inspect})"
      end
    end

    class Or < Atom
      def initialize(left:, right:)
        @left = left
        @right = right
      end

      def parse(parser)
        left_clone =
          Parser.new(
            root: self,
            input: parser.input,
            cursor: parser.cursor,
            buffer: parser.buffer,
          )

        right_clone =
          Parser.new(
            root: self,
            input: parser.input,
            cursor: parser.cursor,
            buffer: parser.buffer,
          )

        begin
          @left.parse(left_clone)
          parser.cursor = left_clone.cursor
          parser.buffer = left_clone.buffer
          parser.output.merge(left_clone.output)
        rescue Parser::Interuption
          @right.parse(right_clone)
          parser.cursor = right_clone.cursor
          parser.buffer = right_clone.buffer
          parser.output.merge(right_clone.output)
        end
      end

      def to_s
        "((#{@left}) | (#{@right}))"
      end
    end

    class And < Atom
      def initialize(left:, right:)
        @left = left
        @right = right
      end

      def parse(parser)
        @left.parse(parser)
        right_clone =
          Parser.new(
            root: self,
            input: parser.input,
            cursor: parser.cursor,
            buffer: parser.buffer,
          )
        @right.parse(right_clone)
        parser.cursor = right_clone.cursor
        parser.buffer = right_clone.buffer

        parser.output.merge(right_clone.output)
      end

      def to_s
        "#{@left} >> #{@right}".to_s
      end
    end

    def any
      Any.new
    end

    def str(string)
      Str.new(string: string)
    end

    def absent
      Absent.new(parent: self)
    end

    def ignore
      Ignore.new(parent: self)
    end

    def maybe
      Maybe.new(parent: self)
    end

    def repeat(min = 0, max = nil)
      Repeat.new(parent: self, min: min, max: max)
    end

    def aka(name)
      Aka.new(parent: self, name: name)
    end

    def |(other)
      Or.new(left: self, right: other)
    end

    def >>(other)
      And.new(left: self, right: other)
    end

    def <<(other)
      And.new(left: self, right: other)
    end

    def then(&block)
      Then.new(parent: self, block: block)
    end

    def rule(name)
      Rule.new(name: name)
    end

    def parse(parser)
      raise NotImplementedError.new("#{self.class}#parse")
    end

    def to_s
      ""
    end

    def inspect
      to_s
    end
  end
end
