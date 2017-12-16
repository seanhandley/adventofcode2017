defmodule KnotHash do
  def lengths_as_ints(input) do
    input
    |> String.split(",")
    |> Enum.map(&(String.to_integer(&1)))
  end

  def starting_list do
    (0..255)
    |> Enum.to_list
  end

  def hash_step(list, skip_size \\ 0, skew \\ 0)
  def hash_step(list, skip_size, skew) do
    Enum.map(list, )
    {list, skip_size, skew}
  end
  def _hash_step() do
    
  end
end