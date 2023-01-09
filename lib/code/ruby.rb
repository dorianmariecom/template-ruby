class Code
  class Ruby
    def initialize(raw = {})
      @raw = raw
    end

    def self.to_code(raw)
      new(raw).to_code
    end

    def self.from_code(raw)
      new(raw).from_code
    end

    def to_code
      if code?
        raw
      elsif nil?
        ::Code::Object::Nothing.new
      elsif true?
        ::Code::Object::Boolean.new(raw)
      elsif false?
        ::Code::Object::Boolean.new(raw)
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
      elsif hash?
        ::Code::Object::Dictionnary.new(
          raw
            .map do |key, value|
              [::Code::Ruby.to_code(key), ::Code::Ruby.to_code(value)]
            end
            .to_h
        )
      elsif array?
        ::Code::Object::List.new(
          raw.map { |element| ::Code::Ruby.to_code(element) }
        )
      elsif proc?
        ::Code::Object::RubyFunction.new(raw)
      else
        raise "Unsupported class #{raw.class} for Ruby to Code conversion"
      end
    end

    def from_code
      if code?
        if code_nothing?
          raw.raw
        elsif code_boolean?
          raw.raw
        elsif code_decimal?
          raw.raw
        elsif code_integer?
          raw.raw
        elsif code_nothing?
          raw.raw
        elsif code_range?
          raw.raw
        elsif code_string?
          raw.raw
        elsif code_dictionnary?
          raw
            .raw
            .map do |key, value|
              [::Code::Ruby.from_code(key), ::Code::Ruby.from_code(value)]
            end
            .to_h
        elsif code_list?
          raw.raw.map { |element| ::Code::Ruby.from_code(element) }
        else
          raise "Unsupported class #{raw.class} for Code to Ruby conversion"
        end
      else
        raw
      end
    end

    private

    attr_reader :raw

    def code?
      raw.is_a?(::Code::Object)
    end

    def nil?
      raw.is_a?(::NilClass)
    end

    def true?
      raw.is_a?(::TrueClass)
    end

    def false?
      raw.is_a?(::FalseClass)
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

    def proc?
      raw.is_a?(::Proc)
    end

    def code_nothing?
      raw.is_a?(::Code::Object::Nothing)
    end

    def code_boolean?
      raw.is_a?(::Code::Object::Boolean)
    end

    def code_decimal?
      raw.is_a?(::Code::Object::Decimal)
    end

    def code_integer?
      raw.is_a?(::Code::Object::Integer)
    end

    def code_nothing?
      raw.is_a?(::Code::Object::Nothing)
    end

    def code_range?
      raw.is_a?(::Code::Object::Range)
    end

    def code_string?
      raw.is_a?(::Code::Object::String)
    end

    def code_dictionnary?
      raw.is_a?(::Code::Object::Dictionnary)
    end

    def code_list?
      raw.is_a?(::Code::Object::List)
    end
  end
end
