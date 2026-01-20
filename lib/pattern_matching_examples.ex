defmodule PatternMatchingExamples do
  @moduledoc """
  Comprehensive examples of pattern matching in Elixir across different data structures.
  """

  # =============================================================================
  # BASIC PATTERN MATCHING
  # =============================================================================

  @doc """
  Basic variable assignment and matching examples.
  """
  def basic_matching_examples do
    IO.puts("=== Basic Pattern Matching ===")

    # Simple assignment (always matches)
    x = 42
    IO.puts("x = #{x}")

    # Pin operator (^) to match against existing value
    y = 10
    # This matches because y is already 10
    ^y = 10
    IO.puts("Pin operator matched: y = #{y}")

    # Pattern matching with literals
    {:ok, message} = {:ok, "Success!"}
    IO.puts("Matched tuple: #{message}")

    # This would fail: {:ok, message} = {:error, "Failed"}
  end

  # =============================================================================
  # LIST PATTERN MATCHING
  # =============================================================================

  @doc """
  Pattern matching with lists - head/tail decomposition and more.
  """
  def list_matching_examples do
    IO.puts("\n=== List Pattern Matching ===")

    # Head and tail matching
    [head | tail] = [1, 2, 3, 4, 5]
    IO.puts("Head: #{head}, Tail: #{inspect(tail)}")

    # Multiple elements from head
    [first, second | rest] = [1, 2, 3, 4, 5]
    IO.puts("First: #{first}, Second: #{second}, Rest: #{inspect(rest)}")

    # Exact list matching
    [a, b, c] = [1, 2, 3]
    IO.puts("Exact match - a: #{a}, b: #{b}, c: #{c}")

    # Empty list matching
    [] = []
    IO.puts("Empty list matched")

    # Ignoring elements with underscore
    [first, _, third] = [1, 2, 3]
    IO.puts("Ignoring middle element - First: #{first}, Third: #{third}")
  end

  @doc """
  Functions demonstrating list pattern matching in function heads.
  """
  def process_list([]), do: "Empty list"
  def process_list([single]), do: "Single element: #{single}"
  def process_list([head | tail]), do: "Head: #{head}, Tail has #{length(tail)} elements"

  def sum_list([]), do: 0
  def sum_list([head | tail]), do: head + sum_list(tail)

  def list_function_examples do
    IO.puts("\n=== List Functions with Pattern Matching ===")
    IO.puts(process_list([]))
    IO.puts(process_list([42]))
    IO.puts(process_list([1, 2, 3, 4]))
    IO.puts("Sum of [1, 2, 3, 4]: #{sum_list([1, 2, 3, 4])}")
  end

  # =============================================================================
  # TUPLE PATTERN MATCHING
  # =============================================================================

  @doc """
  Pattern matching with tuples of various sizes.
  """
  def tuple_matching_examples do
    IO.puts("\n=== Tuple Pattern Matching ===")

    # Two-element tuple
    {x, y} = {10, 20}
    IO.puts("Coordinates: x=#{x}, y=#{y}")

    # Three-element tuple with types
    {name, age, active} = {"Alice", 30, true}
    IO.puts("Person: #{name}, #{age} years old, active: #{active}")

    # Nested tuples
    {{x1, y1}, {x2, y2}} = {{0, 0}, {10, 10}}
    IO.puts("Rectangle from (#{x1},#{y1}) to (#{x2},#{y2})")

    # Common pattern: {:ok, result} and {:error, reason}
    # Using a function that can return either success or error
    results = [simulate_operation(true), simulate_operation(false)]

    Enum.each(results, fn result ->
      case result do
        {:ok, message} -> IO.puts("Success: #{message}")
        {:error, reason} -> IO.puts("Error: #{reason}")
      end
    end)
  end

  @doc """
  Simulates an operation that can succeed or fail.
  """
  def simulate_operation(should_succeed) do
    if should_succeed do
      {:ok, "Operation completed successfully"}
    else
      {:error, "Operation failed"}
    end
  end

  @doc """
  Functions using tuple pattern matching for different return types.
  """
  def divide(a, b) when b != 0, do: {:ok, a / b}
  def divide(_, 0), do: {:error, "Division by zero"}

  def parse_response({:ok, data}), do: "Parsed: #{data}"
  def parse_response({:error, reason}), do: "Failed to parse: #{reason}"

  def tuple_function_examples do
    IO.puts("\n=== Tuple Functions with Pattern Matching ===")

    case divide(10, 2) do
      {:ok, result} -> IO.puts("10 / 2 = #{result}")
      {:error, reason} -> IO.puts("Error: #{reason}")
    end

    case divide(10, 0) do
      {:ok, result} -> IO.puts("10 / 0 = #{result}")
      {:error, reason} -> IO.puts("Error: #{reason}")
    end

    IO.puts(parse_response({:ok, "user data"}))
    IO.puts(parse_response({:error, "network timeout"}))
  end

  # =============================================================================
  # MAP PATTERN MATCHING
  # =============================================================================

  @doc """
  Pattern matching with maps - extracting specific keys and values.
  """
  def map_matching_examples do
    IO.puts("\n=== Map Pattern Matching ===")

    # Exact key matching
    %{name: name, age: age} = %{name: "Bob", age: 25, city: "New York"}
    IO.puts("Matched map - Name: #{name}, Age: #{age}")

    # Partial matching (ignoring other keys)
    %{name: person_name} = %{name: "Charlie", age: 30, occupation: "Developer"}
    IO.puts("Partial match - Name: #{person_name}")

    # String keys vs atom keys
    %{"id" => id, "status" => status} = %{"id" => 123, "status" => "active", "extra" => "data"}
    IO.puts("String keys - ID: #{id}, Status: #{status}")

    # Mixed key types
    %{"type" => user_type, id: user_id} = %{"type" => "admin", id: 456, name: "Dave"}
    IO.puts("Mixed keys - ID: #{user_id}, Type: #{user_type}")

    # Nested map matching
    %{user: %{name: nested_name, profile: %{role: role}}} =
      %{user: %{name: "Eve", profile: %{role: "manager", department: "IT"}}}

    IO.puts("Nested match - Name: #{nested_name}, Role: #{role}")
  end

  @doc """
  Functions demonstrating map pattern matching in function definitions.
  """
  def greet_user(%{name: name, role: "admin"}), do: "Hello Admin #{name}!"
  def greet_user(%{name: name, role: "user"}), do: "Hello #{name}!"
  def greet_user(%{name: name}), do: "Hello #{name}! (no role specified)"
  def greet_user(_), do: "Hello stranger!"

  def process_api_response(%{"success" => true, "data" => data}) do
    "API Success: #{inspect(data)}"
  end

  def process_api_response(%{"success" => false, "error" => error}) do
    "API Error: #{error}"
  end

  def process_api_response(_), do: "Unknown API response format"

  def map_function_examples do
    IO.puts("\n=== Map Functions with Pattern Matching ===")

    IO.puts(greet_user(%{name: "Alice", role: "admin"}))
    IO.puts(greet_user(%{name: "Bob", role: "user"}))
    IO.puts(greet_user(%{name: "Charlie"}))
    IO.puts(greet_user(%{id: 123}))

    IO.puts(process_api_response(%{"success" => true, "data" => %{"id" => 1}}))
    IO.puts(process_api_response(%{"success" => false, "error" => "Not found"}))
    IO.puts(process_api_response(%{"unknown" => "format"}))
  end

  # =============================================================================
  # STRUCT PATTERN MATCHING
  # =============================================================================

  defmodule Person do
    defstruct [:name, :age, :email]
  end

  defmodule Product do
    defstruct [:id, :name, :price, :category]
  end

  @doc """
  Pattern matching with structs.
  """
  def struct_matching_examples do
    IO.puts("\n=== Struct Pattern Matching ===")

    # Basic struct matching
    person = %Person{name: "Frank", age: 28, email: "frank@example.com"}
    %Person{name: name, age: age} = person
    IO.puts("Person matched - Name: #{name}, Age: #{age}")

    # Struct type verification
    # This ensures it's a Person struct
    %Person{} = person
    IO.puts("Confirmed: it's a Person struct")

    # Partial struct matching
    %Person{name: person_name} = person
    IO.puts("Partial struct match - Name: #{person_name}")
  end

  @doc """
  Functions using struct pattern matching.
  """
  def describe_person(%Person{name: name, age: age}) when age >= 18 do
    "#{name} is an adult (#{age} years old)"
  end

  def describe_person(%Person{name: name, age: age}) do
    "#{name} is a minor (#{age} years old)"
  end

  def calculate_discount(%Product{category: "electronics", price: price}) when price > 1000 do
    # 10% discount for expensive electronics
    price * 0.1
  end

  def calculate_discount(%Product{category: "books", price: price}) do
    # 5% discount for books
    price * 0.05
  end

  def calculate_discount(%Product{price: price}) do
    # 2% default discount
    price * 0.02
  end

  def struct_function_examples do
    IO.puts("\n=== Struct Functions with Pattern Matching ===")

    adult = %Person{name: "Grace", age: 25, email: "grace@example.com"}
    minor = %Person{name: "Henry", age: 16, email: "henry@example.com"}

    IO.puts(describe_person(adult))
    IO.puts(describe_person(minor))

    laptop = %Product{id: 1, name: "Gaming Laptop", price: 1500, category: "electronics"}
    book = %Product{id: 2, name: "Elixir Guide", price: 30, category: "books"}
    shirt = %Product{id: 3, name: "T-Shirt", price: 20, category: "clothing"}

    IO.puts("Laptop discount: $#{calculate_discount(laptop)}")
    IO.puts("Book discount: $#{calculate_discount(book)}")
    IO.puts("Shirt discount: $#{calculate_discount(shirt)}")
  end

  # =============================================================================
  # COMPLEX PATTERN MATCHING
  # =============================================================================

  @doc """
  Complex pattern matching combining different data structures.
  """
  def complex_matching_examples do
    IO.puts("\n=== Complex Pattern Matching ===")

    # List of tuples
    users = [{"Alice", 30}, {"Bob", 25}, {"Charlie", 35}]
    [first_user | _] = users
    {first_name, first_age} = first_user
    IO.puts("First user: #{first_name}, #{first_age} years old")

    # Map with list values
    %{users: [%{name: leader_name} | _]} = %{
      users: [%{name: "Diana", role: "lead"}, %{name: "Eve", role: "dev"}]
    }

    IO.puts("Team leader: #{leader_name}")

    # Nested structures
    response = %{
      status: :ok,
      data: %{
        users: [
          %{id: 1, name: "John", tags: ["admin", "active"]},
          %{id: 2, name: "Jane", tags: ["user"]}
        ]
      }
    }

    %{
      status: :ok,
      data: %{
        users: [
          %{name: admin_name, tags: ["admin" | _]} | _
        ]
      }
    } = response

    IO.puts("Found admin user: #{admin_name}")
  end

  @doc """
  Advanced pattern matching in case statements.
  """
  def process_command(command) do
    case command do
      # Simple atom matching
      :help ->
        "Displaying help information"

      :quit ->
        "Goodbye!"

      # Tuple matching with guards
      {:create, name} when is_binary(name) and byte_size(name) > 0 ->
        "Creating item: #{name}"

      # Map matching with multiple conditions
      %{action: "update", id: id, data: data} when is_integer(id) ->
        "Updating item #{id} with data: #{inspect(data)}"

      # List matching with specific patterns
      ["list", filter] when filter in ["all", "active", "inactive"] ->
        "Listing items with filter: #{filter}"

      # Catch-all with variable binding
      unknown ->
        "Unknown command: #{inspect(unknown)}"
    end
  end

  def case_matching_examples do
    IO.puts("\n=== Case Statement Pattern Matching ===")

    commands = [
      :help,
      :quit,
      {:create, "new_user"},
      {:create, ""},
      %{action: "update", id: 123, data: %{name: "Updated"}},
      ["list", "active"],
      ["list", "invalid"],
      {:unknown, "command"}
    ]

    Enum.each(commands, fn cmd ->
      IO.puts("#{inspect(cmd)} -> #{process_command(cmd)}")
    end)
  end

  # =============================================================================
  # WITH STATEMENT PATTERN MATCHING
  # =============================================================================

  @doc """
  Using 'with' for chaining pattern matches.
  """
  def parse_user_data(data) do
    # Fallback for nil
    with {:ok, parsed} <- Jason.decode(data || "{}"),
         %{"user" => user_data} <- parsed,
         %{"name" => name, "age" => age} when is_binary(name) and is_integer(age) <- user_data do
      {:ok, %{name: name, age: age}}
    else
      {:error, _} -> {:error, "Invalid JSON"}
      %{} -> {:error, "Missing user data"}
      _ -> {:error, "Invalid user format"}
    end
  end

  def with_examples do
    IO.puts("\n=== With Statement Pattern Matching ===")

    valid_json = ~s({"user": {"name": "Alice", "age": 30}})
    invalid_json = ~s({"user": {"name": "Bob"}})
    malformed_json = ~s({"invalid": json})

    IO.puts("Valid: #{inspect(parse_user_data(valid_json))}")
    IO.puts("Invalid: #{inspect(parse_user_data(invalid_json))}")
    IO.puts("Malformed: #{inspect(parse_user_data(malformed_json))}")
  end

  # =============================================================================
  # MAIN DEMO FUNCTION
  # =============================================================================

  @doc """
  Runs all pattern matching examples.
  """
  def demo do
    IO.puts("🎯 Pattern Matching Examples in Elixir")
    IO.puts("=====================================")

    basic_matching_examples()
    list_matching_examples()
    list_function_examples()
    tuple_matching_examples()
    tuple_function_examples()
    map_matching_examples()
    map_function_examples()
    struct_matching_examples()
    struct_function_examples()
    complex_matching_examples()
    case_matching_examples()
    with_examples()

    IO.puts("\n✅ All pattern matching examples completed!")
  end
end

# Add Jason dependency mock for the with example
defmodule Jason do
  def decode("{}"), do: {:ok, %{}}

  def decode(~s({"user": {"name": "Alice", "age": 30}})) do
    {:ok, %{"user" => %{"name" => "Alice", "age" => 30}}}
  end

  def decode(~s({"user": {"name": "Bob"}})) do
    {:ok, %{"user" => %{"name" => "Bob"}}}
  end

  def decode(_), do: {:error, "invalid json"}
end
