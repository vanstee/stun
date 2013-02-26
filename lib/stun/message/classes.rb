module Stun
  class Message
    module Classes
      REQUEST          = 0b00000000000000
      INDICATION       = 0b00000000010000
      SUCCESS_RESPONSE = 0b00000100000000
      FAILURE_RESPONSE = 0b00000100010000
    end
  end
end
