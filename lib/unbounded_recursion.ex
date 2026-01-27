defmodule UnboundedRecursion do
  def browse() do
    browse("/Users/vasile/Maculatura/Testing/ElixirAutomation/shop")
  end

  def browse(path) do
    browse(path, [])
  end

  defp browse(path, acc) do
    cond do
      File.regular?(path) ->
        [path | acc]

      File.dir?(path) ->
        {:ok, items} = File.ls(path)
        acc = browse_items(items, path, acc)

        case File.ls(path) do
          {:ok, items} ->
            acc = browse_items(items, path, acc)
            [path | acc]

          {:error, _reason} ->
            [path | acc]
        end

      true ->
        # Handle symlinks, sockets, or non-existent paths
        [path | acc]
    end
  end

  defp browse_items([], _path, acc), do: acc

  defp browse_items([item | rest], path, acc) do
    full_path = Path.join(path, item)
    acc = browse(full_path, acc)
    browse_items(rest, path, acc)
  end
end
