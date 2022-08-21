class Code
  class Error < StandardError
    class TypeError < ::Code::Error
    end

    class NotFound < ::Code::Error
    end
  end
end
