# Example

**A comprehensive Elixir learning project demonstrating core language concepts and functional programming principles.**

This project serves as an educational resource for developers learning Elixir, showcasing fundamental concepts through practical examples and well-documented code. It covers everything from basic syntax to advanced functional programming patterns.

## 🎯 What You'll Learn

This project demonstrates essential Elixir concepts including:

- **Core Language Features**: Atoms, pattern matching, structs, and data types
- **Functional Programming**: Higher-order functions, immutability, and function composition
- **Control Flow**: Case statements, guards, and conditional logic
- **Data Structures**: Lists, tuples, maps, and their manipulation
- **List Comprehensions**: Powerful data transformation and filtering
- **Pattern Matching**: Destructuring and matching across different data types
- **Recursion**: Tail-recursive and standard recursive implementations
- **Error Handling**: Result tuples, `with` statements, and error patterns
- **Testing**: Unit tests with ExUnit framework

## 📁 Project Structure

### Core Application Files
- `lib/example.ex` - Main application module with atoms, structs, and basic concepts
- `lib/pattern_matching_examples.ex` - Comprehensive pattern matching demonstrations
- `lib/recursion.ex` - Recursive function implementations
- `lib/users.ex` - User data modeling examples

### Learning Scripts
- `fizzbuzz.exs` - Classic FizzBuzz implementation with tests
- `list_comprehensions.exs` - Advanced list comprehension examples
- `higher_order_functions.exs` - Function composition and transformation
- `control_flow.exs` - Conditional logic and flow control
- `bool_examples.exs` - Boolean operations and logic
- `list_example.exs` - List manipulation and processing
- `distances.exs` - Mathematical calculations and data processing
- `lazy.exs` - Lazy evaluation and streams
- `desugar.exs` - Language syntax exploration

### Utility Scripts
- `hello_script.exs` - Simple "Hello World" example
- `executable_script.exs` - Executable script demonstration

## 🚀 Getting Started

### Prerequisites
- Elixir 1.19 or later
- Erlang/OTP compatible version

### Installation

Clone the repository and navigate to the example directory:

```bash
git clone <repository-url>
cd IntroElixir/example
```

Install dependencies:

```bash
mix deps.get
```

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `example` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:example, "~> 0.1.0"}
  ]
end
```

### Running the Application

Start the interactive application:

```bash
mix run
```

Or compile and run:

```bash
mix compile
iex -S mix
```

### Running Individual Examples

Execute any of the learning scripts directly:

```bash
# Run FizzBuzz with tests
elixir fizzbuzz.exs

# Explore list comprehensions
elixir list_comprehensions.exs

# Pattern matching examples
iex -S mix
iex> PatternMatchingExamples.demo()
```

## 📚 Key Examples Explained

### Pattern Matching
The project showcases Elixir's powerful pattern matching across:
- Lists: `[head | tail]` destructuring
- Tuples: `{:ok, result}` and `{:error, reason}` patterns
- Maps: `%{name: name, age: age}` key extraction
- Structs: Type-safe data structure matching

### List Comprehensions
Advanced examples include:
- Nested data transformation
- Mathematical sequence generation
- String manipulation and parsing
- Complex filtering with multiple conditions
- Performance comparisons with `Enum` functions

### Functional Programming
Demonstrations of:
- Pure functions and immutability
- Function composition and piping
- Higher-order functions and closures
- Tail recursion optimization
- Lazy evaluation with streams

## 🧪 Testing

Run the test suite:

```bash
mix test
```

Individual script tests (like FizzBuzz) include embedded ExUnit tests that run automatically.

## 📖 Learning Path

1. **Start with basics**: `lib/example.ex` for atoms, structs, and basic syntax
2. **Pattern matching**: `lib/pattern_matching_examples.ex` for core language feature
3. **Data manipulation**: `list_comprehensions.exs` and `list_example.exs`
4. **Control flow**: `control_flow.exs` and `bool_examples.exs`
5. **Functions**: `higher_order_functions.exs` and `recursion.ex`
6. **Problem solving**: `fizzbuzz.exs` and `distances.exs`

## 🎓 Educational Features


## 📄 Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/example>.
