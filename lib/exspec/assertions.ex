defmacro ExSpec.Assertions do
  @moduledoc """
  This module contains a set of assertions functions that are
  imported by default into your specs.

  In general, a developer will want to use the general
  `should` macro in tests. The macro tries to be smart
  and provide good reporting whenever there is a failure.
  For example, `should some_fun() == 10` will fail (assuming
  `some_fun()` returns 13):

      Expected 10 to be equal to 13

  This module also provides other small convenient functions
  like `should_be_in_delta` and `should_raise` to easily handle other
  common cases as checking a float number or handling exceptions.
  """

  import ExUnit.Assertions

  @doc """
  Expects the `expected` value is true.

  `should` in general tries to be smart and provide a good
  reporting whenever there is a failure. For example,
  `should 10 > 15` is going to fail with a message:

      Expected 10 to be more than 15

  ## Examples

      should true

  """
  defmacro should(expected) do
    quote do
      assert unquote(expected)
    end
  end

  @doc """
  Expects the `expected` value is false.

  `should_not` in general tries to be smart and provide a good
  reporting whenever there is a failure.

  ## Examples

      should_not false

  """
  defmacro should_not(expected) do
    quote do
      refute unquote(expected)
    end
  end

end
