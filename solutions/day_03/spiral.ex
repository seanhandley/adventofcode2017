defmodule Spiral do
  def max_size do
    IO.read(:stdio, :all)
    |> String.to_integer
  end

  defp ordering do
    Enum.cycle([:right, :up, :left, :down])
  end

  defp spiral_sequence do
    build_spiral_sequence(max_size)
  end

  defp build_spiral_sequence(num) do
    Stream.transform(0..num, {0,1}, fn (i, acc) ->
      {diff, count} = acc
      prev = List.fetch(seq, i)
      if count == 2
        new_count = 0
        new_diff  = diff + 1
      else
        new_count = count + 1
        new_diff  = diff
      end

      if i < num do
        {[prev+diff],{new_count, new_diff}, acc}
      else
        {:halt, acc}
      end
    end)
    |> MapSet.new
  end 
end
