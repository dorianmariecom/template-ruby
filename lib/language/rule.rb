class Language
  class Rule
    attr_reader :name

    def initialize(name: :root, language: nil, block: nil, atom: nil)
      @name = name
      @language = language
      @atom = atom
      @block = block
    end

    def parse(parser)
      atom.parse(parser)
    end

    def atom
      @atom ||
        Definition.new(name: name, language: language).instance_eval(&block)
    end

    private

    attr_reader :language, :block
  end
end
