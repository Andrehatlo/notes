# Ruby tricks & tips


## 1. Serve current directory with a HTTP server:

```ruby
ruby -run -ehttpd -- --port 3000
```

###### Dot file wrapper for current directory HTTP server

```ruby
serve () {
  ruby -run -ehttpd -- --port $1
}

serveSSL () {
  ruby -r webrick/https -e "
    WEBrick::HTTPServer.new(
      Port: $1, DocumentRoot: '.', SSLEnable: true, SSLCertName: [%w[CN localhost]]
    ).start
  "
}
```

## 2. Destructuring in assignment and parameter lists

```ruby
response = ["Horse", 37, [3,-1], foo: :bar]
name, age, (x,y), *opts = response
```

### OR

```ruby
def list((head, *tail))
  case tail.length
  when 0
    head
  when 1
    "#{list [head]} & #{list tail}"
  else
    "#{list [head]}, #{list tail}"
  end
end
list %w(Bob Marge Jill Clover) #=> "Bob, Marge, Jill & Clover"
```

## 3. Implicit `===` in `when` statements becomes:

- Equality for primitives
- Match for regex
- `is_a?` for classes
- Call for procs
- and so on...

```ruby
def ticket_class(age)
  case age
  when nil; "Unknown"
  when /∞/; "Cthulhu"
  when String; ticket_class(age.to_i)
  when 100; "Centenarian"
  when 18..21; "Young adult"
  when ->(age) { age < 18 }; "Junior"
  when ->(age) { age >= 65 }; "Senior"
  else "Regular"
  end
end
```

## 4. Hash#to_proc

- Especially when it's used as an inline result cache, e.g:

```ruby
factorial_cache = Hash.new { |h, n| h[n.to_i] = (1..n).inject(:*) || 1 }
100.times.map(&method(:rand)).map(&factorial_cache)
```

### OR:

```ruby
my_hash = ->key{{
  a: 1, b: 2, c: 3, d: 4, e: 5, f: 6
}[key]}

my_hash[:a]
# => 1

[:e, :a, :b, :f, :c, :d].map(&my_hash) # hash is now mappable
# => [5, 1, 2, 6, 3, 4]
```

## 4. The little-known passthrough of arguments in blocks supplied by `Symbol#to_proc`:

```ruby
class Person
  # ...
  def compare_name(b)
    [self.lastname, self.firstname] <=> [b.lastname, b.firstname]
  end
end
people.sort(&:compare_name)
```

## 5. Accept a variable number of parameters by putting any additional parameters into a [doublesplay param](https://repl.it/repls/ConstantBelovedSoftwaresuite)

```ruby
def foo(arg1:, arg2:, **arg_options)
```

> You can easily convert a `Hash` into a `Struct` by "abusing" splats:

```ruby
def hash_to_struct(hash)
  Struct.new(*hash.keys).new(*hash.values)
end
```

> Note: This requires that your hash keys are symbols.

## 6. The safe navigation operator `&.` (Ruby 2.6)

> Basically allows you to call methods __on an object*__ that may or may not exist

```ruby
if my_obj && my_obj.foo
```

> If `my_obj` is a `Hash` or an `MyObj` this would fail for the former, but not the latter.

```ruby
if my_obj&.foo
  puts "myobj has foo method: #{myobj&.foo}"
elsif my_obj[:foo]
  puts "myobj jas no foo method"
end
```

> It returns `nil` when a query returns nothing

```ruby
dataset.where(title: "My Title").first
```

> Would fail with `No method "first" for Nil class`.
> I didn't want to use a temporary value and test if that was null

```ruby
query_result = dataset.where(title: "My Title")
query_result ? query_result.first : nil
```

> We can then simplify this with `&.`:

```ruby
dataset.where(title: 'My Title')&.first
```

> `.then` allows you to pass a block to specify the order of the parameters.
> These are the equivalent:

```ruby
# In three steps with temp vars
filepath = File.join __dir__, data, 'myfile.txt'
file = File.readfilepath
json = JSON.parse file
ret_val = my_function(somevar, json)

# In the standard "method chaining" today
my_function(somevar, JSON.parse(File.read(File.join(__dir__, data, 'myfile.txt'))))

# using .then
File.join(__dir__, data, 'myfile.txt')
  .then{ |filepath| File.read filepath }
  .then{ |file| JSON.parse file }
  .then{ |json| my_function somevar, json }

# using .then and being less verbose,
# also experimentied with "s" for "self", x, and i
File.join(__dir__, data, 'myfile.txt')
  .then{ |ret_val| File.read ret_val }
  .then{ |r| JSON.parse filer }
  .then{ |r| my_function somevar, r }
```

## 7. `!!` to convert values to boolean
