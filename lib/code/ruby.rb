class Code
  class Ruby
    def initialize(raw = {})
      @raw = raw || {}
    end

    def self.convert(raw)
      new(raw).convert
    end

    def convert
      if code?
        raw
      elsif hash?
        ::Code::Object::Dictionnary.new(
          raw.map do |key, value|
            [::Code::Ruby.convert(key), ::Code::Ruby.convert(value)]
          end.to_h
        )
      elsif array?
        ::Code::Object::List.new(
          raw.map do |element|
            ::Code::Ruby.convert(key)
          end
        )
      elsif string?
        ::Code::Object::String.new(raw)
      elsif symbol?
        ::Code::Object::String.new(raw.to_s)
      elsif integer?
        ::Code::Object::Integer.new(raw)
      elsif float?
        ::Code::Object::Decimal.new(raw.to_s)
      elsif big_decimal?
        ::Code::Object::Decimal.new(raw)
      else
        raise "Unsupported class #{raw.class} for Ruby to Code conversion"
      end
    end

    private

    attr_reader :raw

    def code?
      raw.is_a?(::Code::Object)
    end

    def hash?
      raw.is_a?(::Hash)
    end

    def array?
      raw.is_a?(::Array)
    end

    def string?
      raw.is_a?(::String)
    end

    def symbol?
      raw.is_a?(::Symbol)
    end

    def integer?
      raw.is_a?(::Integer)
    end

    def float?
      raw.is_a?(::Float)
    end

    def big_decimal?
      raw.is_a?(::BigDecimal)
    end
  end
end
