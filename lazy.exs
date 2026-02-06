defmodule Lazy do
  def get_longest_word(file_path) do
    File.read!(file_path)
    |> String.split("\n")
    |> Enum.flat_map(fn line -> String.split(line, ~r/\W+/) end)
    |> Enum.filter(fn word -> String.length(word) > 0 end)
    |> Enum.max_by(fn word -> String.length(word) end)
  end

  def get_longest_word_lazy(file_path) do
    File.stream!(file_path)
    |> Stream.flat_map(fn line -> String.split(line, ~r/\W+/) end)
    |> Stream.filter(fn word -> String.length(word) > 0 end)
    |> Enum.max_by(fn word -> String.length(word) end)
  end
end
