class Code
  class Object
    include Comparable

    def evaluate(key, *args, **kargs)
      if %i[== === !=].include?(key)
        comparaison(key, args.first)
      elsif key == :<=>
        compare(args.first)
      elsif key == "&&".to_sym
        and_operator(args.first)
      elsif key == "||".to_sym
        or_operator(args.first)
      else
        raise ::Code::Error::NotFound.new("#{key} not defined on #{inspect}")
      end
    end

    def truthy?
      true
    end

    def falsy?
      !truthy?
    end

    def <=>(other)
      if respond_to?(:raw)
        other.is_a?(::Code::Object) ? raw <=> other.raw : raw <=> other
      else
        self == other
      end
    end

    def ==(other)
      (self <=> other) == 0
    end
    alias_method :eql?, :==

    def hash
      [self.class, raw].hash
    end

    def to_s
      raise NotImplementedError
    end

    private

    def comparaison(key, other)
      if other
        ::Code::Object::Boolean.new(raw.public_send(key, other.raw))
      else
        ::Code::Object::Boolean.new(false)
      end
    end

    def compare(other)
      if other
        ::Code::Object::Integer.new(raw <=> other.raw)
      else
        ::Code::Object::Integer.new(0)
      end
    end

    def and_operator(other)
      if truthy? && other && other.truthy?
        other
      else
        ::Code::Object::Boolean.new(false)
      end
    end

    def or_operator(other)
      if truthy?
        self
      elsif other&.truthy?
        other
      else
        ::Code::Object::Boolean.new(false)
      end
    end
  end
end
