class Language
  class Definition
    class RuleNotFound < Exception
    end

    def initialize(name:, language:)
      @name = name
      @atom = Atom.new
      @language = language
    end

    def any
      @atom = Atom::Any.new
    end

    def str(string)
      @atom = Atom::Str.new(string: string)
    end

    def parse(input)
      @atom.parse(input)
    end

    def rule(name)
      Atom::Rule.new(name: name)
    end

    def find_atom!(name)
      @language.find_atom(name) ||
        raise(RuleNotFound.new("No atom found name #{name.inspect}"))
    end

    def method_missing(method, *args, **kargs, &block)
      method = method.to_s

      if method.to_s.end_with?("?")
        method = method.delete_suffix("?")
        atom = find_atom!(method.to_sym).maybe.dup
      else
        atom = find_atom!(method.to_sym).dup
      end

      atom.block = block
      atom
    end
  end
end
