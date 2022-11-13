class Code
  class Node
    def initialize(parsed)
      raise NotImplementedError.new(parsed.inspect) if parsed.any?
    end

    def evaluate(**args)
      raise NotImplementedError.new(self.class.name)
    end
  end
end
