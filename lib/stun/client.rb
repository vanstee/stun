require 'socket'
require 'stun/message'

module Stun
  class Client
    ANY_INTERFACE_HOST = '0.0.0.0'
    MAX_RESPONSE_LENGTH = 548

    attr_accessor :server, :port

    def initialize(options = {})
      options = default_options.merge(options)
      self.server = options.fetch(:server)
      self.port = options.fetch(:port)
    end

    def request
      send(request_message)
    end

    def send(message)
      listener.bind(ANY_INTERFACE_HOST, self.port)
      sender.send(message.to_bytes, 0, self.server, self.port)
      listener.recv(MAX_RESPONSE_LENGTH)
    end

    private

    def sender
      UDPSocket.new
    end

    def listener
      UDPSocket.new
    end

    def request_message
      Stun::Message.new
    end

    def default_options
      {
        :server => 'stun.l.google.com',
        :port => 19302
      }
    end
  end
end
