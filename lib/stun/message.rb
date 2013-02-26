require 'stun/message/classes'

module Stun
  class Message
    MAGIC_COOKIE = 0x2112A442
    TRANSACTION_ID_LENGTH = 96
    HEADER_LENGTH = 160
    MAX_PACK_LENGTH = 32
    BINDING_METHOD = 0b00000000000001

    attr_accessor :message_class, :transaction_id

    def initialize(options = {})
      options = default_options.merge(options)
      self.message_class = options.fetch(:message_class)
      self.transaction_id = options.fetch(:transaction_id)
    end

    def payload
      [
        type,
        length,
        MAGIC_COOKIE,
        chunked_transaction_id
      ].flatten
    end

    def to_bytes
      # n  => type
      # n  => length
      # N  => MAGIC_COOKIE
      # N3 => chunked_transaction_id
      payload.pack('nnNN3')
    end

    def type
      message_class & message_method
    end

    def message_method
      BINDING_METHOD
    end

    def length
      HEADER_LENGTH
    end

    def chunked_transaction_id
      number_of_chunks = TRANSACTION_ID_LENGTH / MAX_PACK_LENGTH

      (0...number_of_chunks).map { |chunk|
        shift = chunk * MAX_PACK_LENGTH
        mask = 2 ** MAX_PACK_LENGTH
        (transaction_id >> shift) & mask
      }.reverse
    end

    private

    def generate_transaction_id
      rand(2 ** TRANSACTION_ID_LENGTH)
    end

    def default_options
      {
        :message_class => Classes::REQUEST,
        :transaction_id => generate_transaction_id
      }
    end
  end
end
