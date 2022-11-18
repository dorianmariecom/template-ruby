class Language
  class Output
    attr_reader :raw

    def initialize(raw = nil)
      @raw = raw
    end

    def clone
      Output.new(@raw.clone)
    end

    def present?
      @raw != nil
    end

    def ==(other)
      other.is_a?(Output) ? raw == other.raw : raw == other
    end

    def to_s
      raw.to_s
    end

    def inspect
      raw.inspect
    end

    def []=(key, value)
      case @raw
      when NilClass
        @raw = { key => value }
      when String
        @raw = { key => value }
      when Array
        @raw << Output.new({ key => value })
      when Hash
        @raw[key] = value
      end
    end

    def merge(other)
      case @raw
      when NilClass
        @raw = other.raw
      when String
        case other.raw
        when String
          @raw = @raw + other.raw
        when Array
          @raw = other.raw
        when Hash
          @raw = other.raw
        end
      when Array
        case other.raw
        when String
          return
        when Array
          @raw = @raw + other.raw
        when Hash
          @raw << other
        end
      when Hash
        case other.raw
        when String
          return
        when Array
          return
        when Hash
          @raw.merge!(other.raw)
        end
      end
    end

    def <<(other)
      case @raw
      when NilClass
        case other.raw
        when String
          @raw = [other]
        when Array
          @raw = [other]
        when Hash
          @raw = [other]
        end
      when String
        case other.raw
        when String
          @raw = @raw + other.raw
        when Array
          @raw = [other]
        when Hash
          @raw = [other]
        end
      when Array
        @raw << other
      when Hash
        case other.raw
        when String
          return
        when Array
          return
        when Hash
          @raw.merge!(other.raw)
        end
      end
    end
  end
end
