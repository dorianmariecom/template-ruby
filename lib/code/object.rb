class Code
  class Object
    include Comparable

    def call(**args)
      operator = args.fetch(:operator, nil)
      arguments = args.fetch(:arguments, [])
      if %w[== === !=].detect { |o| operator == o }
        comparaison(operator.to_sym, arguments)
      elsif operator == "<=>"
        compare(arguments)
      elsif operator == "&&"
        and_operator(arguments)
      elsif operator == "||"
        or_operator(arguments)
      elsif operator == "to_string"
        to_string(arguments)
      else
        raise ::Code::Error::Undefined.new(
                "#{operator} not defined on #{inspect}",
              )
      end
    end

    def []=(key, value)
      @attributes ||= {}
      @attributes[key] = value
    end

    def [](key)
      @attributes ||= {}
      @attributes[key]
    end

    def key?(key)
      @attributes ||= {}
      @attributes.key?(key)
    end

    def truthy?
      true
    end

    def falsy?
      !truthy?
    end

    def <=>(other)
      if respond_to?(:raw)
        other.respond_to?(:raw) ? raw <=> other.raw : raw <=> other
      else
        other <=> self
      end
    end

    def ==(other)
      if respond_to?(:raw)
        other.respond_to?(:raw) ? raw == other.raw : raw == other
      else
        other == self
      end
    end
    alias_method :eql?, :==

    def hash
      if respond_to?(:raw)
        [self.class, raw].hash
      else
        raise NotImplementedError
      end
    end

    def to_s
      raise NotImplementedError
    end

    private

    def sig(actual_arguments, *expected_arguments)
      if actual_arguments.size != expected_arguments.size
        raise ::Code::Error::ArgumentError.new(
                "Expected #{expected_arguments.size} arguments, " \
                  "got #{actual_arguments.size} arguments",
              )
      end

      expected_arguments.each.with_index do |expected_argument, index|
        actual_argument = actual_arguments[index].value

        if expected_argument.is_a?(Array)
          if expected_argument.none? { |expected_arg|
               actual_argument.is_a?(expected_arg)
             }
            raise ::Code::Error::TypeError.new(
                    "Expected #{expected_argument}, got #{actual_argument.class}",
                  )
          end
        else
          if !actual_argument.is_a?(expected_argument)
            raise ::Code::Error::TypeError.new(
                    "Expected #{expected_argument}, got #{actual_argument.class}",
                  )
          end
        end
      end
    end

    def comparaison(operator, arguments)
      sig(arguments, ::Code::Object)
      other = arguments.first.value
      ::Code::Object::Boolean.new(public_send(operator, other))
    end

    def compare(arguments)
      sig(arguments, ::Code::Object)
      other = arguments.first.value
      ::Code::Object::Integer.new(self <=> other)
    end

    def and_operator(arguments)
      sig(arguments, ::Code::Object)
      other = arguments.first.value
      truthy? ? other : self
    end

    def or_operator(arguments)
      sig(arguments, ::Code::Object)
      other = arguments.first.value
      truthy? ? self : other
    end

    def to_string(arguments)
      sig(arguments)
      ::Code::Object::String.new(to_s)
    end
  end
end
