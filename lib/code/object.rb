class Code
  class Object
    def fetch(_key, default = ::Code::Object::Nothing.new)
      default
    end

    def to_s
      raise NotImplementedError
    end
  end
end
