class Code
  class Object
    def fetch(_key)
      ::Code::Object::Nothing.new
    end

    def to_s
      raise NotImplementedError
    end
  end
end
