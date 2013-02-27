require 'spec_helper'
require 'stun/message'

describe Stun::Message do
  describe 'initialization' do
    it 'passes the options to a new header' do
      options = { :message_class => Stun::Message::Classes::REQUEST }

      Stun::Message::Header.should_receive(:new).with(options)

      Stun::Message.new(options)
    end
  end

  describe 'converting to raw bytes' do
    it 'delegates to the header' do
      message = Stun::Message.new

      message.header.should_receive(:to_bytes) { 'raw binary string' }

      expect(message.to_bytes).to eq('raw binary string')
    end
  end

  describe 'length of message' do
    it 'delegates to the header' do
      message = Stun::Message.new

      message.header.should_receive(:length) { 400 }

      expect(message.length).to eq(400)
    end
  end
end
