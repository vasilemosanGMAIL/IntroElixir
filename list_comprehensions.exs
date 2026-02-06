defmodule ListComprehensions do
  @moduledoc """
  Comprehensive examples of Elixir list comprehensions.

  List comprehensions are a powerful feature that allow solving complex problems
  in a single, declarative expression. They can replace multiple Enum operations
  and make code more readable and concise.

   for
   generator
   filter
   into: destination
   do: result_item

   generator: pattern <- list
   filter: predicate (guard)
  """

  @doc """
  Basic comprehension - simple transformation
  """
  def basic_range_example() do
    lengths = 1..20
    for x <- lengths, do: x
  end

  @doc """
  Pythagorean triples - comprehension with filters
  Finds all Pythagorean triples (a² + b² = c²) where a < b and both are <= 20
  """
  def pythagorean_triples() do
    lengths = 1..20
    for x <- lengths, y <- lengths, z <- lengths, x * x + y * y == z * z, x < y, do: {x, y, z}
  end

  @doc """
  Pattern matching in generators
  """
  def pattern_matching_examples() do
    users = [
      {:user, 1, "Alice", 25},
      {:user, 2, "Bob", 30},
      {:user, 3, "Charlie", 17}
    ]

    # Extract just names
    names = for {:user, _, name, _} <- users, do: name

    # Extract adults with their info
    adults = for {:user, id, name, age} <- users, age >= 18, do: %{id: id, name: name, age: age}

    {names, adults}
  end

  @doc """
  Working with nested data structures
  """
  def nested_data_examples() do
    departments = [
      {:dept, "Engineering",
       [
         {:employee, "Alice", 75000},
         {:employee, "Bob", 80000}
       ]},
      {:dept, "Marketing",
       [
         {:employee, "Charlie", 60000},
         {:employee, "Diana", 65000}
       ]}
    ]

    # Flatten all employees with department info
    all_employees =
      for {:dept, dept_name, employees} <- departments,
          {:employee, name, salary} <- employees,
          do: %{name: name, department: dept_name, salary: salary}

    # High earners across all departments
    high_earners =
      for {:dept, dept_name, employees} <- departments,
          {:employee, name, salary} <- employees,
          salary > 70000,
          do: "#{name} (#{dept_name}): $#{salary}"

    {all_employees, high_earners}
  end

  @doc """
  String manipulation with comprehensions
  """
  def string_examples() do
    text = "Hello World"

    # Convert to list of uppercase characters
    upper_chars = for <<char <- text>>, do: String.upcase(<<char>>)

    # Filter only letters and convert to atoms
    letter_atoms =
      for <<char <- text>>,
          (char >= ?a and char <= ?z) or (char >= ?A and char <= ?Z),
          do: String.to_atom(String.downcase(<<char>>))

    # Character frequencies
    char_list = for <<char <- text>>, char != ?\s, do: char

    {upper_chars, letter_atoms, char_list}
  end

  @doc """
  Mathematical sequences and operations
  """
  def mathematical_examples() do
    # Perfect squares up to 100
    perfect_squares = for x <- 1..10, do: x * x

    # Prime numbers up to 50 (simple sieve)
    primes =
      for x <- 2..50,
          Enum.all?(2..(x - 1), fn divisor -> rem(x, divisor) != 0 end),
          do: x

    # Fibonacci-like sequence generation
    fibs = for n <- 1..10, do: fibonacci(n)

    # Multiplication table
    mult_table = for x <- 1..5, y <- 1..5, do: {x, y, x * y}

    {perfect_squares, primes, fibs, mult_table}
  end

  @doc """
  Using different collection types as generators
  """
  def collection_type_examples() do
    # Maps as generators
    user_map = %{alice: 25, bob: 30, charlie: 17}
    adult_names = for {name, age} <- user_map, age >= 18, do: name

    # Tuples and lists mixed
    coordinates = [{1, 2}, {3, 4}, {5, 6}]
    distances = for {x, y} <- coordinates, do: :math.sqrt(x * x + y * y)

    # Keyword lists
    config = [host: "localhost", port: 4000, ssl: false]
    string_configs = for {key, value} <- config, do: "#{key}=#{value}"

    {adult_names, distances, string_configs}
  end

  @doc """
  Into option - collecting into different data structures
  """
  def into_examples() do
    numbers = 1..5

    # Into a map
    number_map = for x <- numbers, into: %{}, do: {x, x * x}

    # Into a binary (string)
    number_string = for x <- numbers, into: "", do: to_string(x)

    # Into a MapSet
    unique_squares = for x <- [1, 2, 2, 3, 3, 4], into: MapSet.new(), do: x * x

    {number_map, number_string, unique_squares}
  end

  @doc """
  Complex filtering and transformation
  """
  def complex_filtering_examples() do
    # Generate all possible poker hands (simplified)
    suits = [:hearts, :diamonds, :clubs, :spades]
    ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

    # All cards
    deck = for suit <- suits, rank <- ranks, do: {rank, suit}

    # All possible pairs of cards (combinations, not permutations)
    pairs =
      for {rank1, suit1} <- deck,
          {rank2, suit2} <- deck,
          {rank1, suit1} < {rank2, suit2},
          do: [{rank1, suit1}, {rank2, suit2}]

    # Same rank pairs
    same_rank_pairs =
      for {rank1, suit1} <- deck,
          {rank2, suit2} <- deck,
          rank1 == rank2,
          suit1 < suit2,
          do: [{rank1, suit1}, {rank2, suit2}]

    {length(deck), length(pairs), length(same_rank_pairs)}
  end

  @doc """
  Performance comparison helper - not a comprehension example but useful for testing
  """
  def performance_comparison() do
    data = 1..10000

    # Using comprehension
    comp_time =
      :timer.tc(fn ->
        for x <- data, rem(x, 2) == 0, do: x * x
      end)

    # Using Enum functions
    enum_time =
      :timer.tc(fn ->
        data
        |> Enum.filter(&(rem(&1, 2) == 0))
        |> Enum.map(&(&1 * &1))
      end)

    {comp_time, enum_time}
  end

  # Helper function for fibonacci example
  defp fibonacci(1), do: 1
  defp fibonacci(2), do: 1
  defp fibonacci(n), do: fibonacci(n - 1) + fibonacci(n - 2)

  @doc """
  Real world example: Log processing
  """
  def log_processing_example() do
    log_entries = [
      "2024-01-01 10:00:00 INFO User login: alice",
      "2024-01-01 10:05:00 ERROR Database connection failed",
      "2024-01-01 10:06:00 INFO User login: bob",
      "2024-01-01 10:10:00 WARN High memory usage detected",
      "2024-01-01 10:15:00 ERROR Service timeout"
    ]

    # Parse and filter error logs
    error_logs =
      for log <- log_entries,
          [date, time, level, message] = String.split(log, " ", parts: 4),
          level == "ERROR",
          do: %{
            timestamp: "#{date} #{time}",
            level: level,
            message: message
          }

    # Extract all unique log levels
    log_levels =
      for log <- log_entries,
          [_, _, level, _] = String.split(log, " ", parts: 4),
          into: MapSet.new(),
          do: level

    {error_logs, log_levels}
  end

  @doc """
  Matrix operations using comprehensions
  """
  def matrix_examples() do
    # Create a 3x3 identity matrix
    identity_3x3 = for i <- 0..2, j <- 0..2, do: if(i == j, do: 1, else: 0)

    # Matrix as list of lists
    matrix = for i <- 0..2, do: for(j <- 0..2, do: i * 3 + j + 1)

    # Transpose a matrix
    transpose = for j <- 0..2, do: for(i <- 0..2, do: Enum.at(Enum.at(matrix, i), j))

    {identity_3x3, matrix, transpose}
  end
end
