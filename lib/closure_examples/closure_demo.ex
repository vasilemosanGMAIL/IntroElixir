defmodule ClosureDemo do
  @moduledoc """
  Demonstrates closure mechanisms in Elixir, comparing them to JavaScript patterns.
  """

  @doc """
  Basic closure - function that returns another function with access to outer scope.
  Similar to JavaScript: function outer(x) { return function(y) { return x + y; }; }
  """
  def basic_closure(x) do
    fn y -> x + y end
  end

  @doc """
  Counter closure - maintains state through closure.
  JavaScript equivalent:
  function createCounter() {
    let count = 0;
    return function() { return ++count; };
  }
  """
  def create_counter do
    # In Elixir, we use an Agent for mutable state
    {:ok, agent} = Agent.start_link(fn -> 0 end)

    fn ->
      Agent.get_and_update(agent, fn count ->
        new_count = count + 1
        {new_count, new_count}
      end)
    end
  end

  @doc """
  Functional counter using closure over immutable data.
  Returns both the current count and a new counter function.
  """
  def functional_counter(count \\ 0) do
    current = count
    next_counter = fn -> functional_counter(count + 1) end
    {current, next_counter}
  end

  @doc """
  Multiplier factory - closure over a multiplier value.
  JavaScript: function createMultiplier(factor) { return x => x * factor; }
  """
  def create_multiplier(factor) do
    fn x -> x * factor end
  end

  @doc """
  Closure with multiple captured variables.
  JavaScript:
  function createGreeter(greeting, punctuation) {
    return function(name) { return greeting + " " + name + punctuation; };
  }
  """
  def create_greeter(greeting, punctuation) do
    fn name -> "#{greeting} #{name}#{punctuation}" end
  end

  @doc """
  Closure that captures and modifies behavior based on configuration.
  JavaScript:
  function createValidator(rules) {
    return function(value) { return rules.every(rule => rule(value)); };
  }
  """
  def create_validator(rules) do
    fn value ->
      Enum.all?(rules, fn rule -> rule.(value) end)
    end
  end

  @doc """
  Partial application using closures.
  JavaScript: const add = (a, b, c) => a + b + c; const addTen = add.bind(null, 10);
  """
  def add(a, b, c), do: a + b + c

  def create_adder(first_num) do
    fn second_num ->
      fn third_num ->
        add(first_num, second_num, third_num)
      end
    end
  end

  @doc """
  Closure over a collection with filtering.
  JavaScript:
  function createFilter(items) {
    return function(predicate) { return items.filter(predicate); };
  }
  """
  def create_filter(items) do
    fn predicate ->
      Enum.filter(items, predicate)
    end
  end

  @doc """
  Demo function that shows various closure examples in action.
  """
  def demo do
    IO.puts("=== Elixir Closure Examples ===\n")

    # Basic closure
    add_five = basic_closure(5)
    IO.puts("Basic closure - add_five.(3): #{add_five.(3)}")

    # Counter with mutable state
    counter = create_counter()
    IO.puts("Counter: #{counter.()}, #{counter.()}, #{counter.()}")

    # Functional counter
    {count1, next1} = functional_counter()
    {count2, next2} = next1.()
    {count3, _next3} = next2.()
    IO.puts("Functional counter: #{count1}, #{count2}, #{count3}")

    # Multiplier factory
    double = create_multiplier(2)
    triple = create_multiplier(3)
    IO.puts("Multipliers - double.(4): #{double.(4)}, triple.(4): #{triple.(4)}")

    # Greeter
    casual_greeter = create_greeter("Hey", "!")
    formal_greeter = create_greeter("Good morning", ".")
    IO.puts("Greetings: #{casual_greeter.("Alice")}")
    IO.puts("Greetings: #{formal_greeter.("Bob")}")

    # Validator
    is_positive = fn x -> x > 0 end
    is_even = fn x -> rem(x, 2) == 0 end
    positive_even_validator = create_validator([is_positive, is_even])
    IO.puts("Validator - 4 is positive and even: #{positive_even_validator.(4)}")
    IO.puts("Validator - 3 is positive and even: #{positive_even_validator.(3)}")

    # Partial application
    add_ten = create_adder(10)
    add_ten_and_five = add_ten.(5)
    result = add_ten_and_five.(2)
    IO.puts("Partial application - 10 + 5 + 2 = #{result}")

    # Filter closure
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    number_filter = create_filter(numbers)
    evens = number_filter.(fn x -> rem(x, 2) == 0 end)
    greater_than_five = number_filter.(fn x -> x > 5 end)
    IO.puts("Filtered evens: #{inspect(evens)}")
    IO.puts("Filtered > 5: #{inspect(greater_than_five)}")

    IO.puts("\n=== Comparison with JavaScript ===")
    IO.puts("JavaScript closures and Elixir closures work very similarly:")
    IO.puts("- Both capture variables from outer scope")
    IO.puts("- Both maintain access to captured variables")
    IO.puts("- Both can be used for partial application and factories")

    IO.puts(
      "- Key difference: Elixir is immutable, so 'mutable' state requires Agents/GenServers"
    )
  end
end
