# Closures: JavaScript vs Elixir

This document provides a side-by-side comparison of closure mechanisms in JavaScript and Elixir.

## Basic Closures

### JavaScript
```javascript
function createAdder(x) {
    return function(y) {
        return x + y;
    };
}

const addFive = createAdder(5);
console.log(addFive(3)); // 8
```

### Elixir
```elixir
def create_adder(x) do
  fn y -> x + y end
end

add_five = create_adder(5)
IO.puts(add_five.(3)) # 8
```

## Counter with State

### JavaScript
```javascript
function createCounter() {
    let count = 0;
    return function() {
        return ++count;
    };
}

const counter = createCounter();
console.log(counter()); // 1
console.log(counter()); // 2
console.log(counter()); // 3
```

### Elixir (Mutable State with Agent)
```elixir
def create_counter do
  {:ok, agent} = Agent.start_link(fn -> 0 end)
  
  fn ->
    Agent.get_and_update(agent, fn count ->
      new_count = count + 1
      {new_count, new_count}
    end)
  end
end

counter = create_counter()
IO.puts(counter.()) # 1
IO.puts(counter.()) # 2
IO.puts(counter.()) # 3
```

### Elixir (Functional Approach)
```elixir
def functional_counter(count \\ 0) do
  current = count
  next_counter = fn -> functional_counter(count + 1) end
  {current, next_counter}
end

{count1, next1} = functional_counter()     # {0, function}
{count2, next2} = next1.()                 # {1, function}
{count3, _next3} = next2.()                # {2, function}
```

## Factory Functions

### JavaScript
```javascript
function createMultiplier(factor) {
    return function(number) {
        return number * factor;
    };
}

const double = createMultiplier(2);
const triple = createMultiplier(3);

console.log(double(5));  // 10
console.log(triple(5));  // 15
```

### Elixir
```elixir
def create_multiplier(factor) do
  fn number -> number * factor end
end

double = create_multiplier(2)
triple = create_multiplier(3)

IO.puts(double.(5))  # 10
IO.puts(triple.(5))  # 15
```

## Partial Application

### JavaScript
```javascript
function add(a, b, c) {
    return a + b + c;
}

function createPartialAdder(first) {
    return function(second) {
        return function(third) {
            return add(first, second, third);
        };
    };
}

const addTen = createPartialAdder(10);
const addTenAndFive = addTen(5);
console.log(addTenAndFive(2)); // 17
```

### Elixir
```elixir
def add(a, b, c), do: a + b + c

def create_partial_adder(first) do
  fn second ->
    fn third ->
      add(first, second, third)
    end
  end
end

add_ten = create_partial_adder(10)
add_ten_and_five = add_ten.(5)
IO.puts(add_ten_and_five.(2)) # 17
```

## Capturing Multiple Variables

### JavaScript
```javascript
function createGreeter(greeting, punctuation) {
    return function(name) {
        return `${greeting} ${name}${punctuation}`;
    };
}

const casualGreeter = createGreeter("Hey", "!");
const formalGreeter = createGreeter("Good morning", ".");

console.log(casualGreeter("Alice"));    // "Hey Alice!"
console.log(formalGreeter("Bob"));      // "Good morning Bob."
```

### Elixir
```elixir
def create_greeter(greeting, punctuation) do
  fn name -> "#{greeting} #{name}#{punctuation}" end
end

casual_greeter = create_greeter("Hey", "!")
formal_greeter = create_greeter("Good morning", ".")

IO.puts(casual_greeter.("Alice"))    # "Hey Alice!"
IO.puts(formal_greeter.("Bob"))      # "Good morning Bob."
```

## Higher-Order Functions with Closures

### JavaScript
```javascript
function createValidator(rules) {
    return function(value) {
        return rules.every(rule => rule(value));
    };
}

const isPositive = x => x > 0;
const isEven = x => x % 2 === 0;
const positiveEvenValidator = createValidator([isPositive, isEven]);

console.log(positiveEvenValidator(4));  // true
console.log(positiveEvenValidator(3));  // false
```

### Elixir
```elixir
def create_validator(rules) do
  fn value ->
    Enum.all?(rules, fn rule -> rule.(value) end)
  end
end

is_positive = fn x -> x > 0 end
is_even = fn x -> rem(x, 2) == 0 end
positive_even_validator = create_validator([is_positive, is_even])

IO.puts(positive_even_validator.(4))  # true
IO.puts(positive_even_validator.(3))  # false
```

## Array/List Processing with Closures

### JavaScript
```javascript
function createFilter(items) {
    return function(predicate) {
        return items.filter(predicate);
    };
}

const numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
const numberFilter = createFilter(numbers);

const evens = numberFilter(x => x % 2 === 0);
const greaterThanFive = numberFilter(x => x > 5);

console.log(evens);           // [2, 4, 6, 8, 10]
console.log(greaterThanFive); // [6, 7, 8, 9, 10]
```

### Elixir
```elixir
def create_filter(items) do
  fn predicate ->
    Enum.filter(items, predicate)
  end
end

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
number_filter = create_filter(numbers)

evens = number_filter.(fn x -> rem(x, 2) == 0 end)
greater_than_five = number_filter.(fn x -> x > 5 end)

IO.inspect(evens)           # [2, 4, 6, 8, 10]
IO.inspect(greater_than_five) # [6, 7, 8, 9, 10]
```

## Key Similarities

1. **Variable Capture**: Both languages capture variables from outer scope
2. **Lexical Scoping**: Variables are bound at definition time, not runtime
3. **Factory Pattern**: Both can create specialized functions
4. **Partial Application**: Both support currying and partial application
5. **Higher-Order Functions**: Both can pass and return functions

## Key Differences

1. **Mutability**: 
   - JavaScript: Variables can be mutated within closures
   - Elixir: All data is immutable; use Agents/GenServers for mutable state

2. **Syntax**:
   - JavaScript: `function() {}` or `() => {}`
   - Elixir: `fn -> end` and called with `func.(args)`

3. **State Management**:
   - JavaScript: Direct variable mutation
   - Elixir: Functional approaches or explicit state containers

4. **Error Handling**:
   - JavaScript: Try/catch, undefined behavior
   - Elixir: Pattern matching, {:ok, result} | {:error, reason}

## Performance Considerations

- **JavaScript**: Closures can create memory leaks if not handled properly
- **Elixir**: Immutable data and garbage collection handle memory automatically
- **Elixir**: Process isolation means closure failures don't crash the system

## When to Use Closures

### Good Use Cases:
- Factory functions for creating specialized behavior
- Partial application and currying
- Event handlers with captured context
- Configuration-based function creation
- Maintaining encapsulated state (with proper state management in Elixir)

### Elixir-Specific Advantages:
- Process isolation makes closures safer
- Pattern matching works well with closure return values
- Immutability prevents accidental state corruption
- Built-in concurrency primitives for stateful closures