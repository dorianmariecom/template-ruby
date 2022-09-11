- `bin/template timeout`
- code `{ temperature:  }`
- `defined?(name) ? name : nothing`
- `while false end == nothing`
- reference
- editor
- string interpolation
- `function(:fibonnaci)`
- `method(:to_string)`
- &block
- `"a" + 1`
- `1 + "a"`
- `{}.each`

```
{
  fibonnaci = (n) => {
    if n < 2
      n
    else
      fibonnaci(n - 1) + fibonnaci(n - 2)
    end
  }

  fibonnaci(5)
```
