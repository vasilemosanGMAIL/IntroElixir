defmodule Users do
  # new/2
  def new(name, age) do
    formatted_text = Helpers.Format.trim_text(name)
    %{name: formatted_text, age: age}
  end

  # new/0
  def new, do: generate_default_user()

  defp generate_default_user do
    %{name: "John Doe", age: 21}
  end
end
