class Code
  class Object
    include Comparable

    def call(**args)
      operator = args.fetch(:operator, nil)
      arguments = args.fetch(:arguments, [])

      if operator == "=="
        sig(arguments, ::Code::Object)
        equal(arguments.first.value)
      elsif operator == "==="
        sig(arguments, ::Code::Object)
        strict_equal(arguments.first.value)
      elsif operator == "!="
        sig(arguments, ::Code::Object)
        different(arguments.first.value)
      elsif operator == "<=>"
        sig(arguments, ::Code::Object)
        compare(arguments.first.value)
      elsif operator == "&&"
        sig(arguments, ::Code::Object)
        and_operator(arguments.first.value)
      elsif operator == "||"
        sig(arguments, ::Code::Object)
        or_operator(arguments.first.value)
      elsif operator == "to_string"
        sig(arguments)
        to_string
      else
        raise(
          Code::Error::Undefined.new("#{operator} not defined on #{inspect}"),
        )
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
        raise(
          ::Code::Error::ArgumentError.new(
            "Expected #{expected_arguments.size} arguments, " \
              "got #{actual_arguments.size} arguments",
          ),
        )
      end

      expected_arguments.each.with_index do |expected_argument, index|
        actual_argument = actual_arguments[index].value

        if expected_argument.is_a?(Array)
          if expected_argument.none? { |expected_arg|
               actual_argument.is_a?(expected_arg)
             }
            raise(
              ::Code::Error::TypeError.new(
                "Expected #{expected_argument}, got #{actual_argument.class}",
              ),
            )
          end
        else
          if !actual_argument.is_a?(expected_argument)
            raise(
              ::Code::Error::TypeError.new(
                "Expected #{expected_argument}, got #{actual_argument.class}",
              ),
            )
          end
        end
      end
    end

    def equal(other)
      ::Code::Object::Boolean.new(self == other)
    end

    def strict_equal(other)
      ::Code::Object::Boolean.new(self === other)
    end

    def different(other)
      ::Code::Object::Boolean.new(self != other)
    end

    def compare(other)
      ::Code::Object::Integer.new(self <=> other)
    end

    def and_operator(other)
      truthy? ? other : self
    end

    def or_operator(other)
      truthy? ? self : other
    end

    def to_string
      ::Code::Object::String.new(to_s)
    end
  end
end
