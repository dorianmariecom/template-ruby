class Code
  class Object
    class Nothing < ::Code::Object
      def to_s
        ""
      end

      def inspect
        "nothing"
      end

      def ==(other)
        other.is_a?(::Code::Object::Nothing)
      end
      alias_method :eql?, :==

      def hash
        [self.class, nil].hash
      end
    end
  end
end
