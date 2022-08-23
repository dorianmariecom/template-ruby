class Code
  class Error < StandardError
    class TypeError < ::Code::Error
    end

    class Undefined < ::Code::Error
    end

    class UndefinedVariable < ::Code::Error
    end
  end
end
