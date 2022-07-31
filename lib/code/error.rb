class Code
  class Error < StandardError
    class TypeError < ::Code::Error
    end
  end
end
