defmodule Redistribute do
  def memory do
    IO.read(:stdio,:all)
    |> String.split
    |> Enum.map(&(String.to_integer(&1)))
  end

  def execute(memory, history \\ MapSet.new, redistributions \\ 0)
  def execute(memory, history, redistributions) do
    if MapSet.member?(history, memory) do
      {memory, redistributions}
    else
      {index, value} = largest_bank(memory)
      List.update_at(memory, index, &(&1 - &1))
      |> redistribute(index+1, value)
      |> execute(MapSet.put(history, memory), redistributions + 1)
    end
  end

  defp redistribute(memory, _index, amount_remaining) when amount_remaining == 0 do
    memory
  end
  defp redistribute(memory, index, amount_remaining) do
    List.update_at(memory, rem(index,Enum.count(memory)), &(&1 + 1))
    |> redistribute(index + 1, amount_remaining - 1)
  end

  defp largest_bank(memory) do
    value = Enum.max(memory)
    index = Enum.find_index(memory, &(&1 == value))
    {index, value}
  end
end
