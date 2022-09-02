# Template

See [templatelang.com](https://templatelang.com) for the full documentation and
live code editing.

## The programming language

Hi, I'm [Dorian Marié](https://dorianmarie.fr), I created Template to let users of my websites provide templates to customize their experience.

Template is meant to be:

- **Simple**: `Hello` and `Hello {name}`
- **Safe**: Can be provided user input
- **Powerful**: Functions, object-oriented, built-in methods

Template is currently written in Ruby and embeddable as a Ruby gem.

## Install

### As a command line tool:

```bash
$ gem install template-ruby
$ template --input "Hello {name}" --context '{ name: "Dorian" }'
Hello Dorian
$ template --input "1 + 2 = {1 + 2}"
1 + 2 = 3
```

### As a Ruby gem:

In a `Gemfile`:

```ruby
gem "template-ruby"
```

Then `$ bundle install`

Then you can use Template like:

```ruby
Template.render("Hello {name}", '{ name: "Dorian" }')
# => "Hello Dorian"
Template.render("1 + 2 = {1 + 2}")
# => "1 + 2 = 3"
Template.render(input, context, io: StringIO.new, timeout: 10)
```

The context is a sub-language called Code, you can use it like:

```ruby
Code.evaluate("1 + 2") # => 3
```

## Future work

- Extend standard library
- Global methods from Ruby, e.g. `{markdown "**bold**"}`
- Object methods from Ruby, e.g. `{"**bold**".markdown}`
- Classes, e.g. `{class User end}`
- Write JavaScript version
- Write Crystal version

## Contributing

Feel free to open [issues](https://github.com/dorianmariefr/template-ruby/issues),
and [pull requests](https://github.com/dorianmariefr/template-ruby/pulls).

To develop locally:

```text
$ git clone https://github.com/dorianmariefr/template-ruby
$ cd template-ruby
$ bundle
$ rspec
$ bin/template -i docs/...
```

## Credits

Thanks to [thoughtbot](https://thoughtbot.com) who let me work on this programming
language as a Friday project.

Thanks to [Kaspar Schiess](https://github.com/kschiess) who made
[Parslet](https://kschiess.github.io/parslet/), the gem that helped me write the parser.

Inspiration from [Ruby](https://www.ruby-lang.org/en/) and
[Liquid](https://shopify.github.io/liquid/).

## License

MIT

Copyright 2022 Dorian Marié <dorian@dorianmarie.fr>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
