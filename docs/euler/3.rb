n = 600_851_475_143
max = 0

i = 2

until n == 1
  if n % i == 0
    max = i
    n = n / i
  end

  i += 1
end

puts max
