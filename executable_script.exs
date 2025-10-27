#!/usr/bin/env elixir

defmodule ExecutableScript do
  @moduledoc """
  An example of an executable Elixir script that can be run directly
  with ./executable_script.exs after making it executable with chmod +x
  """

  def run do
    IO.puts("Hello from an executable Elixir script!")

    # Get command line arguments
    args = System.argv()
    IO.puts("Script arguments: #{inspect(args)}")

    # Processing based on arguments
    if length(args) > 0 do
      process_args(args)
    else
      display_help()
    end

    # Demo some Elixir features
    demo_features()
  end

  def process_args(args) do
    case List.first(args) do
      "greet" ->
        name = if length(args) > 1, do: Enum.at(args, 1), else: "World"
        IO.puts("Hello, #{name}!")

      "add" ->
        if length(args) >= 3 do
          a = String.to_integer(Enum.at(args, 1))
          b = String.to_integer(Enum.at(args, 2))
          IO.puts("#{a} + #{b} = #{a + b}")
        else
          IO.puts("Error: 'add' requires two numbers")
        end

      "date" ->
        current_date = Date.utc_today()
        IO.puts("Today's date: #{current_date}")

      command ->
        IO.puts("Unknown command: #{command}")
        display_help()
    end
  end

  def display_help do
    IO.puts("""

    Usage:
      ./executable_script.exs COMMAND [ARGS]

    Commands:
      greet [NAME]     - Greet the user or specified name
      add NUM1 NUM2    - Add two numbers together
      date             - Display today's date

    Example:
      ./executable_script.exs greet Alice
      ./executable_script.exs add 5 10
    """)
  end

  def demo_features do
    IO.puts("\n--- Elixir Features Demo ---")

    # Working with lists
    list = Enum.to_list(1..5)
    IO.puts("List: #{inspect(list)}")
    IO.puts("Doubled: #{inspect(Enum.map(list, &(&1 * 2)))}")

    # Pattern matching
    {status, message} = {:ok, "Operation successful"}
    IO.puts("Status: #{status}, Message: #{message}")

    # Using pipe operator
    result =
      1..10
      |> Enum.filter(&(rem(&1, 2) == 0))
      |> Enum.map(&(&1 * 3))
      |> Enum.sum()
    IO.puts("Sum of even numbers multiplied by 3: #{result}")
  end
end

# Main execution - this runs when the script is executed
ExecutableScript.run()
