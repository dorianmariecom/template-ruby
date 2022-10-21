class Code
  class Error < StandardError
    class TypeError < ::Code::Error
    end

    class Undefined < ::Code::Error
    end

    class UndefinedVariable < ::Code::Error
    end

    class ArgumentError < ::Code::Error
    end

    class IncompatibleContext < ::Code::Error
    end
  end
end
