require 'spec_helper'
require 'stun/message/header'

describe Stun::Message::Header do
  describe 'initialization' do
    it 'sets default values' do
      Stun::Message::Header.any_instance.stub(:generate_transaction_id) { 8675309 }

      header = Stun::Message::Header.new

      expect(header.message_class).to eq(Stun::Message::Classes::REQUEST)
      expect(header.transaction_id).to eq(8675309)
    end

    it 'allows custom options to override the default' do
      Stun::Message::Header.any_instance.stub(:generate_transaction_id) { 8675309 }

      header = Stun::Message::Header.new(:transaction_id => 3141592)

      expect(header.message_class).to eq(Stun::Message::Classes::REQUEST)
      expect(header.transaction_id).to eq(3141592)
    end
  end

  describe 'converting to raw bytes' do
    it 'returns a binary string' do
      header = Stun::Message::Header.new

      bytes = header.to_bytes

      expect(bytes).to be_a(String)
      expect(bytes).to have(20).characters
    end
  end
end
