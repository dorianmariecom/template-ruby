- `{}.each`
- `0.0 >> 2`

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
