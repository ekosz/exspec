# ExSpec - Specs in your Elixir!

Tired of your boring ExUnit tests?  Wish you have the descriptive powers of
RSpec, Speclj, or Jasmine?  Well now you can!  Lets look at some code.

```elixir
defmodule MathSpec do
  use ExSpec.Case, async: true

  describe ".sum" do
    it "adds 1 and 1 to 2" do
      expect Math.sum(1, 1) == 2
    end

    it "adds 5 and 7 to 13" do
      expect Math.sum(5, 7) == 13
    end
  end

  describe ".divide" do
    context "with dangerous numbers" do
      it "blows up with 0" do
        expectRaises Math.divide(3, 0)
      end
    end
  end
end
```

** THIS IS A WORK IN PROGRESS - SUPER NOT WORKING **
