defmodule Desugar do
  # This shows that:
  # - `def` is actually a macro that takes two arguments
  # - The first argument is the function signature: `len([])`
  # - The second argument is a keyword list with the `do` key: `[do: 0]`
  # - The `do: 0` syntax is just syntactic sugar for `[do: 0]
  def len([]), do: 0
  def(len([]), do: 0)
  
  def(some_fun(arg1, arg2), [do: (a = arg1 + arg2; a + 42)])
end

defmodule(MyDesugaredModule,  [do: ( def f1(), do: 42; def f2(), do: 100    ),])