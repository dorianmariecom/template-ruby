# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.3.0 / ?

- `bin/template` accepts `--timeout` (or `-t`) parameter
- Adds `bin/code` with same options as `bin/template`
- Prevent loose syntax like `{ a: }`, `[1,,,]` and `()`
- Change precedence of defined? (to allow `defined?(name) ? name : nothing`)
- Updates parsers to allow `while false end == nothing`
- String interpolations like `"1 + 1 = {1 + 1}"`
- `context(:name)` to get a function without calling it for instance
- `.to_string` on all objects
- `1 + "a"` and `"a" + 1.0` for instance now convert to strings
- `Dictionnary#each` e.g. `{ a: 1 }.each { |k, v| print(k) }`

## 0.2.4 / 2022-08-02

- Add method `String#*`, e.g. `{"Dorian " \* 2}" -> "Dorian Dorian "
- Add executable to gem, e.g. `template --help`

## 0.2.3 / 2022-08-31

- Add default timeout for code and template parsing and evaluation

## 0.2.2 / 2022-08-31

- Fix parsing error when the template is empty, e.g. ""

## 0.2.1 / 2022-08-31

- Fix parsing error on empty code like `Hello {`

## 0.2.0 / 2022-08-30

- Programming language capable of solving the first 5 Project Euler problems

## 0.1.0 / 2022-07-28

- Initial version with interpolation
