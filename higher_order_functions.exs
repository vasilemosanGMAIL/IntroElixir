defmodule HigherOrderFunctions do
  def test_data() do
    [
      {:user, 1, "Bob", 23},
      {:user, 2, "Alice", 30},
      {:user, 3, "Eve", 15},
      {:user, 4, "Mallory", 10},
      {:user, 5, "Trent", 46}
    ]
  end

  def split_by_age(users, age_limit) do
    pred1 = fn {:user, _, _, age} -> age < age_limit end
    pred2 = fn user -> not pred1.(user) end

    users1 = Enum.filter(users, pred1)
    users2 = Enum.filter(users, pred2)

    {users1, users2}
  end

  @doc """
  Enum.reduce/3 -> acc
  arg:
  - collection
  - accumulator
  - reducer function

  reducer/2 -> new_accumulator
  arg:
  - item
  - accumulator

  Example:
  Enum.reduce([1, 2, 3, 4, 5], 0, fn item, acc -> item + acc end) # 15
  Enum.reduce([1, 2, 3, 4, 5], 1, fn item, acc -> item * acc end) # 120
  """

  def split_by_age_reducer(users, age_limit) do
    Enum.reduce(users, {[], []}, fn
      {:user, _, _, age} = user, {younger, older} when age < age_limit ->
        {[user | younger], older}

      user, {younger, older} ->
        {younger, [user | older]}
    end)
  end

  def get_avg_age(users) do
    reducer = fn {:user, _, _, age}, {num_users, total_age} ->
      {num_users + 1, total_age + age}
    end

    {num_users, total_age} =
      Enum.reduce(users, {0, 0}, reducer)

    total_age / num_users
  end

  @doc """
  Enum.reduce/2 -> single_value
  arg:
  - collection
  - reducer function

  reducer/2 -> new_accumulator
  arg:
  - item
  - accumulator
  Example:
  Enum.reduce([1, 2, 3, 4, 5], fn item, acc -> item + acc end) # 15
  Enum.reduce([1, 2, 3, 4, 5], fn item, acc -> item * acc end) # 120
  """

  def get_oldest_user(users) do
    Enum.reduce(users, fn curr_user, acc ->
      {:user, _, _, curr_age} = curr_user
      {:user, _, _, max_age} = acc
      if curr_age > max_age, do: curr_user, else: acc
    end)
  end

  @type user :: {:user, integer(), String.t(), integer()}
  @type attr_type :: :id | :name | :age
  @type direction :: :asc | :desc

  @spec sort_by_attr([user()], attr_type(), direction()) :: [user()]
  def sort_by_attr(users, attr, direction) do
    sorter =
      case {attr, direction} do
        {:id, :asc} -> &compare_by_id/2
        {:id, :desc} -> invertor(&compare_by_id/2)
        {:name, :asc} -> &compare_by_name/2
        {:name, :desc} -> invertor(&compare_by_name/2)
        {:age, :asc} -> &compare_by_age/2
        {:age, :desc} -> invertor(&compare_by_age/2)
      end

    Enum.sort(users, sorter)
  end

  defp compare_by_id(user1, user2) do
    {:user, id1, _, _} = user1
    {:user, id2, _, _} = user2
    id1 < id2
  end

  defp compare_by_name(user1, user2) do
    {:user, _, name1, _} = user1
    {:user, _, name2, _} = user2
    name1 < name2
  end

  defp compare_by_age(user1, user2) do
    {:user, _, _, age1} = user1
    {:user, _, _, age2} = user2
    age1 < age2
  end

  defp invertor(predicat), do: fn arg1, arg2 -> not predicat.(arg1, arg2) end
end
