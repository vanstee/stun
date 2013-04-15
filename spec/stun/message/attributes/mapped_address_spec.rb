require 'spec_helper'
require 'stun/message/attributes/mapped_address'

describe Stun::Message::Attributes::MappedAddress do
  describe 'IPv4 mapped address' do
    describe 'converting to raw bytes' do
      it 'returns a binary string' do
        mapped_address = Stun::Message::Attributes::MappedAddress.new(
          :family => Stun::Message::Attributes::MappedAddress::IPV4,
          :port => 3478,
          :address => '8.8.8.8'
        )

        bytes = mapped_address.to_bytes

        expect(bytes).to be_a(String)
        expect(bytes).to have(12).bytes
      end
    end
  end

  describe 'IPv6 mapped address' do
    describe 'converting to raw bytes' do
      it 'returns a binary string' do
        mapped_address = Stun::Message::Attributes::MappedAddress.new(
          :family => Stun::Message::Attributes::MappedAddress::IPV6,
          :port => 3478,
          :address => '2001:4860:4860::8888'
        )

        bytes = mapped_address.to_bytes

        expect(bytes).to be_a(String)
        expect(bytes).to have(24).bytes
      end
    end
  end
end
