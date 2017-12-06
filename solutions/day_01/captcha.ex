defmodule Captcha do
  def fetch_input do
    IO.read(:stdio, :all)
    |> String.to_integer
    |> Integer.digits
  end

  def calculate_captcha(input, offset) do
    input
    |> Stream.with_index
    |> Enum.map(fn ({e,i}) ->
      index = offset + i |> rem(length(input))
      {:ok, x} = Enum.fetch(input, index)
      cond do
        x == e -> e
        true   -> 0
      end
    end)
    |> Enum.sum
  end
end
