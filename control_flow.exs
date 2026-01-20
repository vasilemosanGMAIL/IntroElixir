defmodule ControlFlow do
  def handle(animal, action) do
    case animal do
      {:dog, name} ->
        case action do
          :feed -> IO.puts("Feeding dog #{name}")
          :pet -> IO.puts("Petting dog #{name}")
          _ -> IO.puts("Unknown action for dog #{name}")
        end

      {:cat, name} ->
        case action do
          :feed -> IO.puts("Feeding cat #{name}")
          :pet -> IO.puts("Petting cat #{name}")
          _ -> IO.puts("Unknown action for cat #{name}")
        end

      {:rat, name} ->
        case action do
          :feed -> IO.puts("Feeding rat #{name}")
          :pet -> IO.puts("Petting rat #{name}")
          _ -> IO.puts("Unknown action for rat #{name}")
        end
    end
  end

  def handle2(animal, action) do
    case {animal, action} do
      {{:dog, name}, :feed} -> IO.puts("Feeding dog #{name}")
      {{:dog, name}, :pet} -> IO.puts("Petting dog #{name}")
      {{:cat, name}, :feed} -> IO.puts("Feeding cat #{name}")
      {{:cat, name}, :pet} -> IO.puts("Petting cat #{name}")
      {{:rat, name}, :feed} -> IO.puts("Feeding rat #{name}")
      {{:rat, name}, :pet} -> IO.puts("Petting rat #{name}")
      {{animal_type, name}, _} -> IO.puts("Unknown action for #{animal_type} #{name}")
    end
  end

  def handle3({:dog, name}, :feed), do: IO.puts("Feeding dog #{name}")
  def handle3({:dog, name}, :pet), do: IO.puts("Petting dog #{name}")

  # catch all pattern , need to be the last
  def handle3({animal_type, name}, action),
    do: IO.puts("doing action '#{inspect(action)}' with animal '#{inspect(animal_type)}' #{name}")

  # Guards
  def handle6({:library, rating, books}) when rating > 4 and length(books) > 2 do
    IO.puts("A good library")
  end

  def handle6({:library, _, _}) do
    IO.puts("An average library")
  end

  require Integer

  def handle7(number) when Integer.is_even(number) do
    IO.puts("#{number} is even")
  end

  def handle7(number) do
    IO.puts("#{number} is odd")
  end

  def handle8(number) do
    cond do
      number >= 5 -> IO.puts("#{number} is bigger or equal to 5")
      true -> IO.puts("#{number} is zero")
    end
  end

  # elixir don't actually need else in if statementserrr
  def handle9(number) do
    if number >= 0 do
      IO.puts("#{number} is positive")
    else
      IO.puts("#{number} is negative")
    end
  end
end
