require 'ipaddr'
require 'stun/message/attribute'

module Stun
  class Message
    module Attributes
      class MappedAddress < Stun::Message::Attribute
        TYPE = 0x0002
        IPV4 = 0x01
        IPV6 = 0x02
        IPV4_ADDRESS_INTEGER_LENGTH = 32
        IPV6_ADDRESS_INTEGER_LENGTH = 128

        attr_accessor :family, :port, :address

        def initialize(options = {})
          self.family = options.fetch(:family)
          self.port = options.fetch(:port)
          self.address = options.fetch(:address)
        end

        def type
          TYPE
        end

        def length
          return 64  if ipv4?
          return 160 if ipv6?
        end

        def value
          [
            family,
            port,
            chunked_address_integer
          ].flatten
        end

        def value_template
          # n  => family
          # n  => port
          # N  => ipv4 address
          # or
          # N4 => ipv6 address
          "nn#{address_template}"
        end

        def address_integer
          IPAddr.new(address).to_i
        end

        def chunked_address_integer
          Binary.chunked(address_integer)
        end

        def address_template
          return 'N'  if ipv4?
          return 'N4' if ipv6?
        end

        def ipv4?
          family == IPV4
        end

        def ipv6?
          family == IPV6
        end
      end
    end
  end
end
