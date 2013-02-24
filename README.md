Stun
====

Ruby implementation of a STUN client conforming to [RFC
5389](https://tools.ietf.org/html/rfc5389).

Usage
-----

In most cases you'll just want to know your public facing IP address. To simply
ask a STUN server your address without setting any custom options use the
following:

```ruby
response = Stun.request('stun.1.google.com:19302')
response.address # => 8.8.8.8
```

If you need to set any special options you can use the more verbose version:

```ruby
client = Stun::Client.new(server: 'stun.1.google.com:19302')
response = client.request
response.address # => 8.8.8.8
```

If you need really low level access you can also create your own `Message`
objects:

```ruby
client = Stun::Client.new(server: 'stun.1.google.com:19302')
request = Stun::Message.new(type: Stun::Message::REQUEST)
response = client.send(request)
response.address # => 8.8.8.8
```
