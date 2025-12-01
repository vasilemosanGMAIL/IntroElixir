defmodule ListExample do
  @moduledoc """
  This module provides functions for merging sorted lists.
  """

  @doc """
  Merges two sorted lists into a single sorted list.

  This function takes two already-sorted lists and merges them into one
  sorted list, maintaining the sort order. It uses a tail-recursive approach
  with an accumulator for efficiency.

  ## Parameters

  - `list1` - A sorted list (ascending order)
  - `list2` - A sorted list (ascending order)

  ## Returns

  A new list containing all elements from both input lists in sorted order.

  ## Examples

      iex> ListExample.merge([1, 3, 5], [2, 4, 6])
      [1, 2, 3, 4, 5, 6]
  ## Time Complexity
  O(n + m) where n and m are the lengths of the input lists.
  ## Space Complexity
  O(n + m) for the result list, plus O(n + m) stack space for recursion.
  """
  def merge(list1, list2) do
    merge(list1, list2, [])
  end

  # Base case: first list is empty, append remaining second list
  defp merge([], list2, acc), do: Enum.reverse(acc) ++ list2

  # Base case: second list is empty, append remaining first list
  defp merge(list1, [], acc), do: Enum.reverse(acc) ++ list1

  # Recursive case: compare heads and merge accordingly
  defp merge(list1, list2, acc) do
    [head1 | tail1] = list1
    [head2 | tail2] = list2

    if head1 < head2 do
      # head1 is smaller, add it to accumulator and continue with tail1
      acc = [head1 | acc]
      merge(tail1, list2, acc)
    else
      # head2 is smaller or equal, add it to accumulator and continue with tail2
      acc = [head2 | acc]
      merge(list1, tail2, acc)
    end
  end
end

ExUnit.start()

defmodule ListExampleTest do
  use ExUnit.Case
  import ListExample

  test "merges two sorted lists of equal length" do
    assert merge([1, 3, 5], [2, 4, 6]) == [1, 2, 3, 4, 5, 6]
  end

  test "merges two sorted lists of unequal length" do
    assert merge([1, 3], [2, 4, 6]) == [1, 2, 3, 4, 6]
    assert merge([1, 3, 5, 7], [2, 4]) == [1, 2, 3, 4, 5, 7]
  end

  test "handles empty lists" do
    assert merge([], [2, 4, 6]) == [2, 4, 6]
    assert merge([1, 3, 5], []) == [1, 3, 5]
    assert merge([], []) == []
  end

  test "handles single element lists" do
    assert merge([1], [2]) == [1, 2]
    assert merge([2], [1]) == [1, 2]
  end

  test "handles lists with duplicate elements" do
    assert merge([1, 3, 3], [2, 3, 4]) == [1, 2, 3, 3, 3, 4]
  end

  test "handles already sorted concatenated lists" do
    assert merge([1, 2, 3], [4, 5, 6]) == [1, 2, 3, 4, 5, 6]
    assert merge([4, 5, 6], [1, 2, 3]) == [1, 2, 3, 4, 5, 6]
  end
end
