class Language
  class Rule
    attr_reader :name, :atom

    def initialize(name: :root, atom: nil)
      @name = name
      @atom = atom
    end

    def parse(parser)
      @atom.parse(parser) if @atom
    end
  end
end
