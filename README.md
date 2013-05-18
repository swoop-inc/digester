# Digester

Use `Digester` anytime you want to use a complex data structure as a primary key
in a database or a lookup key in a `Hash` or a key-value store.

`Digester` creates an [MD5 digest](http://en.wikipedia.org/wiki/MD5) for Ruby
data structures in a consistent algorithmic manner such that two identical
data structures generate the same digests regardless of how they were
created. 

This way it is also possible to compare data structures and digests
across different programming languages. At [Swoop](http://swoop.com),
we use consistent data structure digests to implement variations of 
[content addressable storage](http://en.wikipedia.org/wiki/Content-addressable_storage) 
across S3, Redis and MongoDB with Ruby, Python and Java clients.

## Installation

Add this line to your application's Gemfile:

    gem 'digester'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install digester

## Usage

```ruby
require 'digester'
data = {x: {y: { z: [1, 2, 3]}}}
Digester::Digester.new.digest(data)
 => "d5221448a0765677cbce09eebd557c61"
Digester::Digester.digest(data, {upcase: true})
 => "D5221448A0765677CBCE09EEBD557C61"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
