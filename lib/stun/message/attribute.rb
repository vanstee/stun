module Stun
  class Message
    class Attribute
      BOUNDARY = 32

      def payload
        [
          type,
          length_rounded_up,
          value
        ].flatten
      end

      def to_bytes
        # n => type
        # n => length_rounded_up
        payload.pack("nn#{value_template}")
      end

      def type
        raise NotImplementedError
      end

      def length
        raise NotImplementedError
      end

      def length_rounded_up
        ((length / BOUNDARY) + 1) * BOUNDARY
      end

      def value
        []
      end

      def value_template
        ''
      end
    end
  end
end
