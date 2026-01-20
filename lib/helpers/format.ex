defmodule Helpers.Format do
  @moduledoc """
  Documentation for Helpers.Format module.
  """

  @doc """
  Trims leading and trailing whitespace from the given text.
  """
  def trim_text(text) do
    String.trim(text)
  end

  def generate_slug(text) do
    # JavaScrip style when inside replace we pass another function
    # Which is hard to read, and execution is from inside out or right to left
    # String.replace(String.trim(String.downcase(text)), " ", "-")

    # Proper Elixir way using pipe operator (left to right execution, more readable)
    # text |> String.trim() |> String.downcase() |> String.replace(" ", "-")
    # Debug
    text
    |> String.trim()
    |> IO.inspect()
    |> String.downcase()
    |> String.replace(" ", "-")
    |> dbg()
  end
end
