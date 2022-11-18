require_relative "./language/parser/interuption"
require_relative "./language/parser"
require_relative "./language/atom"
require_relative "./language/definition"
require_relative "./language/rule"
require_relative "./language/output"

class Language
  VERSION = "0.1.0"

  attr_reader :rules

  def initialize
    @rules = []
    @root = Rule.new
  end

  def self.create(&block)
    instance = new
    instance.instance_eval(&block)
    instance
  end

  def parse(input_or_parser)
    if input_or_parser.is_a?(Parser)
      parser = input_or_parser
      clone =
        Parser.new(
          root: @root,
          rules: @rules,
          input: parser.input,
          cursor: parser.cursor,
          buffer: parser.buffer,
          output: parser.output
        )

      clone.parse(check_end_of_input: false)

      parser.cursor = clone.cursor
      parser.buffer = clone.buffer
      parser.output = clone.output
    else
      input = input_or_parser
      Parser.new(root: @root, rules: @rules, input: input).parse
    end
  end

  def root(&block)
    atom = Definition.new(name: :root, language: self).instance_eval(&block)
    @root = Rule.new(atom: atom)
    nil
  end

  def rule(name, &block)
    atom = Definition.new(name: name, language: self).instance_eval(&block)
    @rules << Rule.new(name: name, atom: atom)
    nil
  end

  def find_rule(name)
    (@rules + [@root]).find { |rule| rule.name == name }
  end

  def find_atom(name)
    find_rule(name)&.atom
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
end
