class Language
  VERSION = "0.1.0"

  def initialize(block: nil)
    @root = root
    @block = block
  end

  def self.parse(input)
    new.parse(input)
  end

  def self.absent
    Atom::Absent.new(parent: new)
  end

  def self.ignore
    Atom::Ignore.new(parent: new)
  end

  def self.maybe(&block)
    Atom::Maybe.new(parent: new, block: block)
  end

  def self.repeat(min = 0, max = nil)
    Atom::Repeat.new(parent: new, min: min, max: max)
  end

  def self.aka(name)
    Atom::Aka.new(parent: new, name: name)
  end

  def self.|(other)
    Atom::Or.new(left: new, right: other)
  end

  def self.>>(other)
    Atom::And.new(left: new, right: other)
  end

  def self.<<(other)
    Atom::And.new(left: new, right: other)
  end

  def parse(input_or_parser)
    if input_or_parser.is_a?(Parser)
      parser = input_or_parser
      clone =
        Parser.new(
          root: @root,
          input: parser.input,
          cursor: parser.cursor,
          buffer: parser.buffer,
          output: parser.output
        )

      clone.parse(check_end_of_input: false)

      parser.cursor = clone.cursor
      parser.buffer = clone.buffer

      if @block
        parser.output = Output.new(@block.call(clone.output))
      else
        parser.output = clone.output
      end
    else
      input = input_or_parser
      Parser.new(root: @root, input: input).parse
    end
  end

  def absent
    Atom::Absent.new(parent: self)
  end

  def ignore
    Atom::Ignore.new(parent: self)
  end

  def maybe
    Atom::Maybe.new(parent: self)
  end

  def repeat(min = 0, max = nil)
    Atom::Repeat.new(parent: self, min: min, max: max)
  end

  def aka(name)
    Atom::Aka.new(parent: self, name: name)
  end

  def |(other)
    Atom::Or.new(left: self, right: other)
  end

  def >>(other)
    Atom::And.new(left: self, right: other)
  end

  def <<(other)
    Atom::And.new(left: self, right: other)
  end

  def str(string)
    Atom::Str.new(string: string)
  end

  def any
    Atom::Any.new
  end

  def to_s
    "<#{self.class.name}>"
  end

  def inspect
    to_s
  end
end
