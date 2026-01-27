# Recursion Examples in Elixir
# This file demonstrates various recursion patterns and explains why Elixir doesn't use traditional loops

IO.puts("=== RECURSION IN ELIXIR ===\n")

# ============================================================================
# WHY NO FOR LOOPS IN ELIXIR?
# ============================================================================

IO.puts("Why doesn't Elixir have for loops?")
IO.puts("1. Elixir is a functional programming language")
IO.puts("2. Data is immutable - you can't modify variables in place")
IO.puts("3. Recursion + pattern matching is more expressive and safer")
IO.puts("4. Tail call optimization makes recursion efficient")
IO.puts("5. Fits better with the Actor model and concurrent programming\n")

# ============================================================================
# BASIC RECURSION EXAMPLES
# ============================================================================

defmodule RecursionExamples do
  # Example 1: Simple countdown (basic recursion)
  def countdown(0) do
    IO.puts("Blast off! 🚀")
  end

  def countdown(n) when n > 0 do
    IO.puts("#{n}...")
    # Add delay for effect
    Process.sleep(500)
    countdown(n - 1)
  end

  # Example 2: Calculate factorial
  def factorial(0), do: 1

  def factorial(n) when n > 0 do
    n * factorial(n - 1)
  end

  # Example 3: Fibonacci sequence
  def fibonacci(0), do: 0
  def fibonacci(1), do: 1

  def fibonacci(n) when n > 1 do
    fibonacci(n - 1) + fibonacci(n - 2)
  end

  # Example 4: Sum of a list (tail recursion)
  def sum_list([]), do: 0

  def sum_list([head | tail]) do
    head + sum_list(tail)
  end

  # Example 5: Tail-recursive sum (more efficient)
  def sum_list_tail(list), do: sum_list_tail(list, 0)

  defp sum_list_tail([], acc), do: acc

  defp sum_list_tail([head | tail], acc) do
    sum_list_tail(tail, acc + head)
  end

  # Example 6: List length using recursion
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)
  # len([3, 8, 3, 4, 5])
  # │
  # ├─ Pattern matches [_head | tail] where:
  # │  ├─ _head = 3 (ignored)
  # │  └─ tail = [8, 3, 4, 5]
  # │
  # └─ Returns: 1 + len([8, 3, 4, 5])
  #            │
  #            ├─ 1 + (1 + len([3, 4, 5]))
  #            │      │
  #            │      ├─ 1 + (1 + len([4, 5]))
  #            │      │      │
  #            │      │      ├─ 1 + (1 + len([5]))
  #            │      │      │      │
  #            │      │      │      └─ 1 + (1 + len([]))
  #            │      │      │             │
  #            │      │      │             └─ 1 + 0 = 1
  #            │      │      └─ 1 + 1 = 2
  #            │      └─ 1 + 2 = 3
  #            └─ 1 + 3 = 4
  # └─ Final result: 5

  # Example 7: Find maximum in a list
  def find_max([]), do: nil
  def find_max([single]), do: single

  def find_max([head | tail]) do
    max(head, find_max(tail))
  end

  # Example 8: Reverse a list
  def reverse_list(list), do: reverse_list(list, [])

  defp reverse_list([], acc), do: acc

  defp reverse_list([head | tail], acc) do
    reverse_list(tail, [head | acc])
  end

  # Example 9: Map function using recursion
  def map_list([], _func), do: []

  def map_list([head | tail], func) do
    [func.(head) | map_list(tail, func)]
  end

  # Example 10: Filter function using recursion
  def filter_list([], _func), do: []

  def filter_list([head | tail], func) do
    if func.(head) do
      [head | filter_list(tail, func)]
    else
      filter_list(tail, func)
    end
  end

  # Example 11: Tree traversal (working with nested structures)
  def traverse_tree(nil), do: []

  def traverse_tree(%{value: value, left: left, right: right}) do
    traverse_tree(left) ++ [value] ++ traverse_tree(right)
  end

  # Example 12: Generate a range (like a for loop would)
  def generate_range(start, finish) when start > finish, do: []

  def generate_range(start, finish) do
    [start | generate_range(start + 1, finish)]
  end

  # Example 13: Repeat an action N times
  def repeat_action(_action, 0), do: :done

  def repeat_action(action, n) when n > 0 do
    action.()
    repeat_action(action, n - 1)
  end

  # Example 14: Processing key-value pairs recursively
  def process_keyword_list([]), do: []

  def process_keyword_list([{key, value} | rest]) do
    processed_value = String.upcase(to_string(value))
    [{key, processed_value} | process_keyword_list(rest)]
  end

  # Sample user data in format {:user, id, name, age}
  def test_data do
    [
      {:user, 1, "Bob", 23},
      {:user, 2, "Alice", 30},
      {:user, 3, "Eve", 15},
      {:user, 4, "Mallory", 10},
      {:user, 5, "Trent", 46}
    ]
  end

  # Entry point: initializes empty accumulators for the recursive helper function
  # This pattern separates the public API from the internal recursion with accumulators
  def split_adults_and_minors(users) do
    split_adults_and_minors(users, [], [])
  end

  # Base case: when list is empty, reverse both accumulator lists
  defp split_adults_and_minors([], adults, minors) do
    {Enum.reverse(adults), Enum.reverse(minors)}
  end

  # Recursive case: process one user at a time
  defp split_adults_and_minors([user | users], adults, minors) do
    # Extract age from user tuple
    {:user, _id, _name, age} = user

    if age >= 16 do
      # Add to adults list and continue with remaining users
      split_adults_and_minors(users, [user | adults], minors)
    else
      # Add to minors list and continue with remaining users
      split_adults_and_minors(users, adults, [user | minors])
    end
  end

  # split_adults_and_minors([{:user, 1, "Bob", 23}, {:user, 3, "Eve", 15}], [], [])
  # │
  # ├─ Pattern matches [user | users] where:
  # │  ├─ user = {:user, 1, "Bob", 23}
  # │  ├─ users = [{:user, 3, "Eve", 15}]
  # │  ├─ adults = []
  # │  └─ minors = []
  # │
  # ├─ Extract age: {:user, _id, _name, age} = {:user, 1, "Bob", 23}
  # │  └─ age = 23
  # │
  # ├─ Check: 23 >= 16? Yes!
  # │  └─ Add Bob to adults list
  # │
  # └─ Recurse: split_adults_and_minors([{:user, 3, "Eve", 15}], [{:user, 1, "Bob", 23}], [])
  #            │
  #            ├─ Pattern matches [user | users] where:
  #            │  ├─ user = {:user, 3, "Eve", 15}
  #            │  ├─ users = []
  #            │  ├─ adults = [{:user, 1, "Bob", 23}]
  #            │  └─ minors = []
  #            │
  #            ├─ Extract age: {:user, _id, _name, age} = {:user, 3, "Eve", 15}
  #            │  └─ age = 15
  #            │
  #            ├─ Check: 15 >= 16? No!
  #            │  └─ Add Eve to minors list
  #            │
  #            └─ Recurse: split_adults_and_minors([], [{:user, 1, "Bob", 23}], [{:user, 3, "Eve", 15}])
  #                       │
  #                       ├─ Pattern matches [] (empty list) - BASE CASE!
  #                       │
  #                       └─ Return: {Enum.reverse([{:user, 1, "Bob", 23}]), Enum.reverse([{:user, 3, "Eve", 15}])}
  #                                 │
  #                                 └─ Final result: {[{:user, 1, "Bob", 23}], [{:user, 3, "Eve", 15}]}
  #                                                   │                        │
  #                                                   └─ Adults                └─ Minors
end

# ============================================================================
# RUNNING THE EXAMPLES
# ============================================================================

IO.puts("=== BASIC RECURSION ===")
IO.puts("Countdown from 5:")
RecursionExamples.countdown(5)

IO.puts("\n=== MATHEMATICAL RECURSION ===")
IO.puts("Factorial of 5: #{RecursionExamples.factorial(5)}")
IO.puts("Fibonacci of 7: #{RecursionExamples.fibonacci(7)}")

IO.puts("\n=== LIST PROCESSING ===")
numbers = [3, 8, 3, 4, 5]
IO.puts("Original list: #{inspect(numbers)}")
IO.puts("Sum: #{RecursionExamples.sum_list(numbers)}")
IO.puts("Sum (tail recursive): #{RecursionExamples.sum_list_tail(numbers)}")
IO.puts("Length: #{RecursionExamples.len(numbers)}")
IO.puts("Maximum: #{RecursionExamples.find_max(numbers)}")
IO.puts("Reversed: #{inspect(RecursionExamples.reverse_list(numbers))}")

IO.puts("\n=== FUNCTIONAL OPERATIONS ===")
doubled = RecursionExamples.map_list(numbers, fn x -> x * 2 end)
IO.puts("Doubled: #{inspect(doubled)}")

evens = RecursionExamples.filter_list(numbers, fn x -> rem(x, 2) == 0 end)
IO.puts("Even numbers: #{inspect(evens)}")

IO.puts("\n=== RANGE GENERATION ===")
range = RecursionExamples.generate_range(1, 5)
IO.puts("Range 1 to 5: #{inspect(range)}")

IO.puts("\n=== TREE TRAVERSAL ===")

tree = %{
  value: 4,
  left: %{
    value: 2,
    left: %{value: 1, left: nil, right: nil},
    right: %{value: 3, left: nil, right: nil}
  },
  right: %{
    value: 6,
    left: %{value: 5, left: nil, right: nil},
    right: %{value: 7, left: nil, right: nil}
  }
}

traversed = RecursionExamples.traverse_tree(tree)
IO.puts("Tree traversal: #{inspect(traversed)}")

IO.puts("\n=== REPEAT ACTION ===")
IO.puts("Printing 'Hello' 3 times:")
RecursionExamples.repeat_action(fn -> IO.puts("Hello!") end, 3)

IO.puts("\n=== KEYWORD LIST PROCESSING ===")
keywords = [name: "john", city: "paris", country: "france"]
processed = RecursionExamples.process_keyword_list(keywords)
IO.puts("Original: #{inspect(keywords)}")
IO.puts("Processed: #{inspect(processed)}")

IO.puts("\n=== USER DATA PROCESSING ===")
users = RecursionExamples.test_data()
IO.puts("All users: #{inspect(users)}")

{adults, minors} = RecursionExamples.split_adults_and_minors(users)
IO.puts("Adults (age >= 16): #{inspect(adults)}")
IO.puts("Minors (age < 16): #{inspect(minors)}")

# ============================================================================
# COMPARISON WITH IMPERATIVE LOOPS
# ============================================================================

IO.puts("\n=== ELIXIR VS IMPERATIVE LOOPS ===")

IO.puts("""
In imperative languages, you might write:
  for i = 1; i <= 5; i++ {
    sum += i;
  }

In Elixir, we use recursion or Enum functions:
""")

# Using Enum (built on recursion internally)
sum_enum = Enum.sum(1..5)
IO.puts("Sum using Enum.sum(1..5): #{sum_enum}")

# Using our recursive function
sum_recursive = RecursionExamples.sum_list([1, 2, 3, 4, 5])
IO.puts("Sum using recursion: #{sum_recursive}")

IO.puts("""

Benefits of recursion over loops:
✓ Immutable data - no side effects
✓ Pattern matching makes code clearer
✓ Tail call optimization for efficiency
✓ Works naturally with functional composition
✓ Safer in concurrent environments
✓ More expressive for complex data structures

Note: Elixir does have 'for' comprehensions, but they're different:
""")

# Elixir's for comprehension (not a loop!)
squares = for n <- 1..5, do: n * n
IO.puts("Squares using for comprehension: #{inspect(squares)}")

filtered_squares = for n <- 1..10, n * n < 50, do: n * n
IO.puts("Filtered squares < 50: #{inspect(filtered_squares)}")

IO.puts("\nElixir's 'for' is actually a comprehension that returns a new collection!")
IO.puts("It's syntactic sugar for Enum.map/2, Enum.filter/2, etc.")
