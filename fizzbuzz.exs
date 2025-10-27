defmodule FizzBuzz do
  @moduledoc """
  Implementation of the classic FizzBuzz programming problem.
  Prints numbers from 1 to 100, replacing multiples of 3 with "Fizz",
  multiples of 5 with "Buzz", and multiples of both with "FizzBuzz".
  """

  @doc """
  Main entry point that:
  1. Generates numbers from 1 to 100
  2. Converts each number according to FizzBuzz rules
  3. Joins results with spaces
  4. Prints the final string
  """
  def main() do
    fizzbuzz100()
    |> Enum.join(" ")
    |> IO.puts()
  end

  def fizzbuzz100() do
    # &fizzbuzz/1 is a shorthand for fn(x) -> fizzbuzz(x) end
    # It captures the fizzbuzz function that takes 1 argument
    Enum.map(1..100, &fizzbuzz/1)
  end

  @doc """
  Converts a number to its FizzBuzz string representation.

  Rules:
  - Returns "FizzBuzz" if number is divisible by both 3 and 5
  - Returns "Fizz" if number is divisible by 3
  - Returns "Buzz" if number is divisible by 5
  - Returns the number as a string otherwise

  ## Parameters
    - number: Integer to convert

  ## Returns
    String representing the FizzBuzz value
  """
  @spec fizzbuzz(number :: integer) :: String.t()
  def fizzbuzz(number) do
    cond do
      rem(number, 3) == 0 and rem(number, 5) == 0 -> "FizzBuzz"
      rem(number, 3) == 0 -> "Fizz"
      rem(number, 5) == 0 -> "Buzz"
      true -> to_string(number)
    end
  end
end

ExUnit.start()

defmodule FizzBuzzTest do
  use ExUnit.Case

  test "fizzbuzz" do
    assert FizzBuzz.fizzbuzz(1) == "1"
    assert FizzBuzz.fizzbuzz(3) == "Fizz"
    assert FizzBuzz.fizzbuzz(5) == "Buzz"
    assert FizzBuzz.fizzbuzz(7) == "7"
    assert FizzBuzz.fizzbuzz(15) == "FizzBuzz"
    assert FizzBuzz.fizzbuzz(11) == "11"
    assert FizzBuzz.fizzbuzz(100) == "Buzz"
  end

  test "fizzbuzz1_00" do
    result = FizzBuzz.fizzbuzz100()
    assert Enum.take(result, 5) == ["1", "2", "Fizz", "4", "Buzz"]
    assert Enum.at(result, 70) == "71"
    assert Enum.at(result, 90) == "91"
    assert Enum.at(result, 99) == "Buzz"
  end
end
