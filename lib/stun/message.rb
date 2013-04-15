require 'stun/message/header'

module Stun
  class Message
    attr_accessor :header

    def initialize(options = {})
      self.header = Header.new(options)
    end

    def to_bytes
      self.header.to_bytes
    end

    def length
      self.header.length
    end
  end
end
