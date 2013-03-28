defmodule ExSpec.Case do
  @moduledoc """
  This module is meant to be used in other modules
  as a way to configure and prepare them for testing.

  When used, it allows the following options:

  * :async - configure Elixir to run that specific test case
             in parallel with others. Must be used for performance
             when your test cases do not change any global state;

  This module automatically includes all callbacks defined
  in `ExSpec.Callbacks`. Read it for more information.

  ## Examples

     defmodule BehaviorSpec do
       use ExSpec.Case, async: true

       it "always passes" do
         should true
       end
     end

  """

  @doc false
  defmacro __using__(opts // []) do
    async  = Keyword.get(opts, :async, false)
    parent = Keyword.get(opts, :parent, __MODULE__)

    quote do
      if unquote(async) do
        ExUnit.Server.add_async_case(__MODULE__)
      else
        ExUnit.Server.add_sync_case(__MODULE__)
      end

      use ExSpec.Callbacks, parent: unquote(parent)

      import ExSpec.Assertions
      import ExSpec.Case
    end
  end

  import ExUnit.Case

  @doc """
  Provides a convenient macro that allows a test to be
  defined with a string. This macro automatically inserts
  the atom :ok as the last line of the test. That said,
  a passing test always returns :ok, but, more important,
  it forces Elixir to not tail call optimize the test and
  therefore avoiding hiding lines from the backtrace.

  ## Examples

      it "true is equal to true" do
        should true == true
      end

  """
  defmacro it(message, var // quote(do: _), contents) do
     quote do
       message = unquote(message)

       message = if is_binary(message) do
         :"should #{message}"
         else
         :"should_#{message}"
       end

       test message, [unquote(Macro.escape var)], [], do:
         unquote(Macro.escape contents, escape_unquote: false)
     end
  end
end
