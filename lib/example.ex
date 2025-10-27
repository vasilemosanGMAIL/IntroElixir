defmodule Example do
  @moduledoc """
  Example application module that demonstrates various Elixir concepts including atoms.
  """
  use Application
  alias UUID

  # Module attribute constant defined at compile time
  @constant 5

  @doc """
  Person struct definition.

  Structs in Elixir are maps with a defined structure and default values.
  They're tied to a module and provide compile-time checks.
  """
  defstruct name: "", age: 0, occupation: nil

  @doc """
  Product struct definition with enforced keys.
  """
  defmodule Product do
    @enforce_keys [:sku]
    defstruct [:sku, :name, price: 0.0, in_stock: true]
  end

  @doc """
  Starts the application.

  Parameters:
    - _type: The type of the application being started
    - _args: Arguments passed to the application

  Returns a supervised process tree.
  """
  def start(_type, _args) do
    IO.puts(UUID.uuid4())
    IO.puts(hello())
    Example.main()
    guess_game()
    # Example2.demo()
    # Uses the atom :one_for_one as a supervision strategy
    Supervisor.start_link([], strategy: :one_for_one)
  end

  @doc """
  Returns the atom :world.

  In Elixir, atoms are constants where their name is their value.
  They start with a colon (e.g., :world) and are used for their
  identity rather than their value.
  """
  def hello do
    # An atom that represents the concept 'world'
    :world
  end

  def guess_game do
    correct = :rand.uniform(11) - 1
    guess = IO.gets("Guess a number between 0 and 10: ") |> String.trim()

    if String.to_integer(guess) == correct do
      IO.puts("You win!")
    else
      IO.puts("You lose! the correct number was #{correct}")
    end
  end

  @doc """
  Main function demonstrating various Elixir concepts including atom usage.
  """

  def main do
    IO.puts("Hello, world!")

    # Integer variable creation
    x = 10
    IO.puts(x)
    IO.puts(@constant)

    name = "John"

    # Randomly select a membership status from a list of atoms
    # Atoms in Elixir are often used to represent discrete states or options
    # Note: :"not a member" is an atom with spaces, requiring quotes
    status = Enum.random([:gold, :silver, :bronze, :"not a member"])

    # Using the === operator to check if status is exactly the :gold atom
    # Atoms are compared by identity, making them perfect for pattern matching
    if status === :gold do
      IO.puts("Welcome to the fancy lounge, #{name}")
    else
      IO.puts("Get lost")
    end

    # Case statement with pattern matching against atom values
    # This is a common use case for atoms in Elixir - representing different states
    case status do
      :gold -> IO.puts("Welcome to the fancy lounge, #{name}")
      :silver -> IO.puts("Welcome to the silver lounge, #{name}")
      :bronze -> IO.puts("Welcome to the bronze lounge, #{name}")
      # The underscore (_) is a catch-all pattern
      _ -> IO.puts("Get out bruh")
    end

    # Numbers
    y = 20
    b = 5
    # division alaways returns a double
    IO.puts(y / b)
    :io.format("~.20f\n", [0.1])
    IO.puts(Float.ceil(0.1, 1))

    # Time
    time = Time.new!(16, 30, 0, 0)
    date = Date.new!(2025, 1, 1)
    date_time = DateTime.new!(date, time, "Etc/UTC")
    IO.puts("Current year: #{date_time.year}")
    IO.inspect(date_time)
    # Calculate the next new year dynamically
    current_date = Date.utc_today()
    current_year = current_date.year
    next_year = current_year + 1
    new_time = DateTime.new!(Date.new!(next_year, 1, 1), Time.new!(0, 0, 0, 0), "Etc/UTC")
    time_till = DateTime.diff(new_time, DateTime.utc_now())
    IO.puts("Time till new year (#{next_year}): #{time_till}")
    days = div(time_till, 86_400)
    IO.puts("Days till new year: #{days} days")
    hours = div(rem(time_till, 86_400), 60 * 60)
    IO.puts("Hours till new year: #{hours} hours")
    minutes = div(rem(time_till, 60 * 60), 60)
    IO.puts("Minutes till new year: #{minutes} minutes")
    seconds = rem(time_till, 60)
    IO.puts("Seconds till new year: #{seconds} seconds")

    IO.puts(
      "Time till new year: #{days} days, #{hours} hours, #{minutes} minutes, #{seconds} seconds"
    )

    # tuples
    memberships = {:bronze, :silver}
    memberships = Tuple.insert_at(memberships, 2, :gold)
    IO.inspect(memberships)
    prices = {5, 10, 15}
    avg = Tuple.sum(prices) / tuple_size(prices)
    IO.puts("average membership prices #{avg}")

    IO.puts(
      "Average price from #{elem(memberships, 0)} #{elem(memberships, 1)} #{elem(memberships, 2)} is #{avg}"
    )

    new_memberhip = %{
      gold: :gold,
      silver: :silver,
      bronze: :bronze,
      none: :none
    }

    prices = %{gold: 50, silver: 30, bronze: 10, none: 0}
    IO.inspect(prices)

    users = [
      {"caleb", new_memberhip.gold},
      {"John", new_memberhip.silver},
      {"Alice", new_memberhip.bronze},
      {"Bob", new_memberhip.gold},
      {"Eve", new_memberhip.silver},
      {"Frank", new_memberhip.bronze}
    ]

    Enum.each(users, fn {name, membership} ->
      IO.puts("#{name} has a #{membership} membership paying #{prices[membership]} dollars")
    end)

    # Demonstrating structs
    IO.puts("\n--- Struct Examples ---")

    # Creating instances of the Person struct (defined at the module level)
    person1 = %Example{name: "Alice", age: 30, occupation: "Developer"}
    IO.inspect(person1, label: "Person struct")

    # Using the struct with default values
    person2 = %Example{name: "Bob"}
    IO.inspect(person2, label: "Person with defaults")

    # Accessing struct fields
    IO.puts("#{person1.name} is #{person1.age} years old and works as a #{person1.occupation}")

    # Updating struct fields (creates a new struct)
    updated_person = %{person2 | age: 25, occupation: "Designer"}
    IO.inspect(updated_person, label: "Updated person")

    # Creating instances of the nested Product struct
    # Note that :sku is enforced by @enforce_keys
    product1 = %Example.Product{sku: "ABC123", name: "Elixir Course", price: 99.99}
    IO.inspect(product1, label: "Product struct")

    # Pattern matching with structs
    %Example{name: name, age: age} = person1
    IO.puts("Extracted name: #{name}, age: #{age}")

    # Function that pattern matches on struct type
    display_entity = fn
      %Example{} = p -> "Person: #{p.name}, #{p.age} years old"
      %Example.Product{} = prod -> "Product: #{prod.name} (#{prod.sku}), $#{prod.price}"
      _ -> "Unknown entity"
    end

    IO.puts(display_entity.(person1))
    IO.puts(display_entity.(product1))
    IO.puts(display_entity.(%{foo: "bar"}))
  end
end
