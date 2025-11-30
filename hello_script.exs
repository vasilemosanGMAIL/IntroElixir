# elixir hello_script.exs
defmodule HelloScript do
  def run do
    IO.puts("Hello from an Elixir script file!")
    IO.puts("This file can be run directly with 'elixir hello_script.exs'")

    # Working with lists
    numbers = [1, 2, 3, 4, 5]
    doubled = Enum.map(numbers, &(&1 * 2))
    IO.puts("Original numbers: #{inspect(numbers)}")
    IO.puts("Doubled numbers: #{inspect(doubled)}")

    # Pattern matching
    {a, b, c} = {1, "hello", :world}
    IO.puts("Pattern matched values - a: #{a}, b: #{b}, c: #{c}")

    # Conditionals
    result = if Enum.sum(numbers) > 10 do
      "Sum is greater than 10"
    else
      "Sum is 10 or less"
    end
    IO.puts(result)
    # String graphemes and character frequencies
    IO.puts("\n--- String Graphemes & Frequencies ---")
    frequencies = "Elixir" |> String.graphemes() |> Enum.frequencies()
    IO.inspect(frequencies, label: "Character frequencies in 'Elixir'")
    # Working with dates
    current_time = Time.utc_now()
    IO.puts("Current time: #{current_time.hour}:#{current_time.minute}:#{current_time.second}")
  end

  def calculate_factorial(n) when n <= 1, do: 1
  def calculate_factorial(n), do: n * calculate_factorial(n - 1)
end

# This code will execute when the script is run
IO.puts("\n=== Starting Script Execution ===\n")
HelloScript.run()

# Demonstrate function call
factorial_of_5 = HelloScript.calculate_factorial(5)
IO.puts("\nFactorial of 5: #{factorial_of_5}")

IO.puts("\n=== Script Execution Complete ===")
