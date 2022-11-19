class Code
  class Node
    def initialize(parsed)
      if parsed.any?
        raise NotImplementedError.new(self.class.name + ": " + parsed.inspect)
      end
    end

    def evaluate(**args)
      raise NotImplementedError.new(self.class.name + "#evaluate")
    end
  end
end
