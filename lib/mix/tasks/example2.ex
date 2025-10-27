defmodule Mix.Tasks.Example2 do
  @moduledoc """
  Mix task to run Example2 functionality from the command line.

  ## Usage

    # Run the demo function
    mix example2 demo

    # Call the greet function with an argument
    mix example2 greet World

    # Process a list of numbers
    mix example2 process_list 1 2 3 4 5

    # Check a status
    mix example2 handle_status ok
  """
  use Mix.Task

  @shortdoc "Runs Example2 module functions"

  @doc """
  Person struct definition with additional fields.
  """
  defstruct name: "", age: 0, email: nil, interests: []

  @impl Mix.Task
  def run(args) do
    # Parse the command and arguments without starting the application
    parse_args(args)
  end

  @doc """
  Simple greeting function that returns a formatted string.
  """
  def greet(name) do
    "Hello, #{name}! Welcome to Example2."
  end

  @doc """
  Demonstrates working with lists in Elixir.
  """
  def process_list(list) do
    Enum.map(list, &(&1 * 2))
  end

  @doc """
  Demonstrates pattern matching with atoms.
  """
  def handle_status(status) do
    case status do
      :ok -> "Everything is fine!"
      :error -> "Something went wrong!"
      :pending -> "Still processing..."
      _ -> "Unknown status"
    end
  end

  defp parse_args([]) do
    IO.puts(
      "Please specify a command. Available commands: demo, greet, process_list, handle_status"
    )

    IO.puts("For example: mix example2 demo")
  end

  defp parse_args(["demo"]) do
    IO.puts("Running Example2 demo...")
    demo()
  end

  defp parse_args(["greet" | [name | _]]) do
    result = greet(name)
    IO.puts(result)
  end

  defp parse_args(["process_list" | numbers]) do
    # Convert string arguments to integers
    list = Enum.map(numbers, &String.to_integer/1)
    result = process_list(list)
    IO.puts("Original: #{inspect(list)}, Doubled: #{inspect(result)}")
  end

  defp parse_args(["handle_status", status_str]) do
    # Convert string to atom
    status = String.to_atom(status_str)
    result = handle_status(status)
    IO.puts("Status #{status}: #{result}")
  end

  defp parse_args([command | _]) do
    IO.puts("Unknown command: #{command}")
    IO.puts("Available commands: demo, greet, process_list, handle_status")
  end

  @doc """
  Demo function showing various examples.
  """
  def demo do
    # Create a person struct
    person = %__MODULE__{
      name: "Alice",
      age: 28,
      email: "alice@example.com",
      interests: ["Elixir", "Functional Programming", "Hiking"]
    }

    IO.puts("Created person: #{person.name}, #{person.age} years old")

    # Work with the struct
    updated_person = %{person | age: person.age + 1}
    IO.puts("After birthday: #{updated_person.name} is now #{updated_person.age}")

    # Handle different statuses
    statuses = [:ok, :error, :pending, :unknown]

    Enum.each(statuses, fn status ->
      result = handle_status(status)
      IO.puts("Status #{status}: #{result}")
    end)

    # Process a list
    numbers = [1, 3, 5, 7, 9]
    doubled = process_list(numbers)
    IO.puts("Original: #{inspect(numbers)}, Doubled: #{inspect(doubled)}")

    # Return the person
    person
  end
end
