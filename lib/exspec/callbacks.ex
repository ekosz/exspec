defmodule ExSpec.Callbacks do
  @moduledoc %B"""
  This module defines four callbacks: `before_all`, `after_all`,
  `before` and `after`. Those callbacks are defined via macros
  and receives a keyword list of metadata. The callback may
  optionally define extra data which will be available in the test
  cases.

  ## Examples

      defmodule BehaviorSpec do
        use ExSpec.Case, async: true

        before do
          IO.puts "This is a setup callback"

          # Returns extra metadata
          { :ok, [hello: "world"] }
        end

        before context do
          # We can access the test name in the context
          IO.puts "Setting up: #{context[:test]}"

          # The metadata returned by the previous setup as well
          should context[:hello] == "world"

          # No metadata
          :ok
        end

        it "always pass" do
          should true
        end
      end

  """

  @doc false
  defmacro __using__(opts) do
    import unquote(__MODULE__)
  end

  import ExUnit.Callbacks

  defmacro before(var // quote(do: _), block) do
    quote do
      setup unquote(var), unquote(block)
    end
  end

  defmacro before_all(var // quote(do: _), block) do
    quote do
      setup_all unquote(var), unquote(block)
    end
  end

  defmacro after(var // quote(do: _), block) do
    quote do
      teardown [unquote(escape var)], [], unquote(escape block)
    end
  end

  defmacro after_all(var // quote(do: _), block) do
    quote do
      teardown_all [unquote(escape var)], [], unquote(escape block)
    end
  end
end
