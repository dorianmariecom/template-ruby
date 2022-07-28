# `template-ruby`

A templating programming language

Like `Hello {name}` with `{name: "Dorian"}` gives `Hello Dorian`.

```ruby
> Template.render("Hello {name}", '{name: "Dorian"}')
=> "Hello Dorian"
```
