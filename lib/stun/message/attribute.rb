module Stun
  class Message
    class Attribute
      BOUNDARY = 32

      attr_accessor :type, :length

      def initialize(options = {})
        options = default_options.merge(options)
        self.type = options.fetch(:type)
        self.length = options.fetch(:length)
      end

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

      def length_rounded_up
        ((length / BOUNDARY) + 1) * BOUNDARY
      end

      def value
        []
      end

      def value_template
        ''
      end

      def default_options
        {}
      end
    end
  end
end
