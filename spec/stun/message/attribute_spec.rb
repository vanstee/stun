require 'spec_helper'
require 'stun/message/attribute'

class FakeAttribute < Stun::Message::Attribute
  def type
    0x0000
  end

  def length
    64
  end
end

describe Stun::Message::Attribute do
  describe 'converting to raw bytes' do
    it 'must be overridden' do
      expect { Stun::Message::Attribute.new.to_bytes }.to raise_error(NotImplementedError)
    end

    it 'returns a binary string' do
      attribute = FakeAttribute.new

      bytes = attribute.to_bytes

      expect(bytes).to be_a(String)
      expect(bytes).to have(4).characters
    end
  end

  describe 'rounding up the length' do
    it 'rounds up to the nearest boundary' do
      attribute = FakeAttribute.new

      attribute.stub(:length) { 54 }

      expect(attribute.length_rounded_up).to eq(64)
    end
  end
end
