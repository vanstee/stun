require 'spec_helper'
require 'stun/message/attribute'

describe Stun::Message::Attribute do
  describe 'initialization' do
    it 'sets default values' do
      Stun::Message::Attribute.any_instance.stub(:default_options) { { :length => 64 } }

      attribute = Stun::Message::Attribute.new(:type => nil, :value => nil)

      expect(attribute.length).to eq(64)
    end

    it 'allows custom options to override the default' do
      Stun::Message::Attribute.any_instance.stub(:default_options) { { :length => 64 } }

      attribute = Stun::Message::Attribute.new(:type => nil, :length => 128, :value => nil)

      expect(attribute.length).to eq(128)
    end
  end

  describe 'converting to raw bytes' do
    it 'returns a binary string' do
      attribute = Stun::Message::Attribute.new(:type => 0x0001, :length => 64, :value => nil)

      bytes = attribute.to_bytes

      expect(bytes).to be_a(String)
      expect(bytes).to have(4).characters
    end
  end

  describe 'rounding up the length' do
    it 'rounds up to the nearest boundary' do
      attribute = Stun::Message::Attribute.new(:type => nil, :length => nil, :value => nil)

      attribute.length = 54

      expect(attribute.length_rounded_up).to eq(64)
    end
  end
end
