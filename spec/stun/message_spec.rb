require 'spec_helper'
require 'stun/message'

describe Stun::Message do
  describe 'initialization' do
    it 'sets default values' do
      Stun::Message.any_instance.stub(:generate_transaction_id) { 8675309 }

      message = Stun::Message.new

      expect(message.message_class).to eq(Stun::Message::REQUEST_CLASS)
      expect(message.transaction_id).to eq(8675309)
    end

    it 'allows custom options to override the default' do
      Stun::Message.any_instance.stub(:generate_transaction_id) { 8675309 }

      message = Stun::Message.new(:transaction_id => 3141592)

      expect(message.message_class).to eq(Stun::Message::REQUEST_CLASS)
      expect(message.transaction_id).to eq(3141592)
    end
  end

  describe 'converting to raw bytes' do
    it 'returns a binary string' do
      message = Stun::Message.new

      bytes = message.to_bytes

      expect(bytes).to be_a(String)
      expect(bytes).to have(20).characters
    end
  end
end
