require 'spec_helper'
require 'stun/client'

describe Stun::Client do
  describe 'initialization' do
    it 'sets default values' do
      client = Stun::Client.new

      expect(client.server).to eq('stun.l.google.com')
      expect(client.port).to eq(19302)
    end

    it 'allows custom options to override the default' do
      client = Stun::Client.new(:server => 'stun1.l.google.com')

      expect(client.server).to eq('stun1.l.google.com')
      expect(client.port).to eq(19302)
    end
  end

  describe 'making a request' do
    it 'returns the response' do
      client = Stun::Client.new
      outgoing_message = stub('Stun::Message')
      incoming_message = stub('Stun::Message')

      client.stub(:request_message) { outgoing_message }
      client.should_receive(:send).with(outgoing_message) { incoming_message }

      expect(client.request).to eq(incoming_message)
    end
  end

  describe 'sending a message' do
    it 'sends a message to the server' do
      client = Stun::Client.new
      outgoing_message = stub('Stun::Message', :to_bytes => 'raw binary string')
      incoming_message = stub('Stun::Message')
      sender = stub('UDPSocket')
      listener = stub('UDPSocket').as_null_object

      client.stub(:sender) { sender }
      client.stub(:listener) { listener }
      sender.should_receive(:send).with('raw binary string', 0, client.server, client.port)

      client.send(outgoing_message)
    end

    it 'waits for and returns a response' do
      client = Stun::Client.new
      outgoing_message = stub('Stun::Message', :to_bytes => 'raw binary string')
      incoming_message = stub('Stun::Message')
      sender = stub('UDPSocket').as_null_object
      listener = stub('UDPSocket')

      client.stub(:sender) { sender }
      client.stub(:listener) { listener }
      listener.should_receive(:bind).with(Stun::Client::ANY_INTERFACE_HOST, client.port)
      listener.should_receive(:recv).with(Stun::Client::MAX_RESPONSE_LENGTH) { incoming_message }

      client.send(outgoing_message)
    end
  end
end
