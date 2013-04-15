module Stun
  class Binary
    MAX_PACK_LENGTH = 32

    def self.chunked(value)
      bytes = Math.log(value) / Math.log(2)
      number_of_chunks = (bytes / MAX_PACK_LENGTH).ceil
      mask = 2 ** MAX_PACK_LENGTH - 1

      (0...number_of_chunks).map { |chunk|
        shift = chunk * MAX_PACK_LENGTH
        (value >> shift) & mask
      }.reverse
    end
  end
end
