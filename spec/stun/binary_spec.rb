require 'spec_helper'
require 'stun/binary'

describe Stun::Binary do
  describe 'splitting up an integer' do
    it 'splits an integer into 32-bit chunks' do
      chunks = Stun::Binary.chunked(0x1111111122222222)

      expect(chunks).to eq([0x11111111, 0x22222222])
    end

    it 'pads the extra bits with zeros' do
      chunks = Stun::Binary.chunked(0x0000111122222222)

      expect(chunks).to eq([0x00001111, 0x22222222])
    end
  end
end
