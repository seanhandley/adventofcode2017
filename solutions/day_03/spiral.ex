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

  # def change_direction?(num)
  #   spiral_sequence.include?(num)
  # end

  # def spiral
  #   @spiral ||= build_spiral
  # end

  # def build_spiral
  #   direction = nil
  #   (1..max_size).each_with_object({}) do |num, spiral|
  #     direction = ordering.next if change_direction?(num)
  #     spiral[num] ||= direction
  #   end
  # end

  # def distance(x, y, orig)
  #   (x - orig).abs + (y - orig).abs
  # end

  # def size
  #   @size || max_size / 4
  # end

  # def calculate_distance
  #   x = y = original_coords = size / 2
  #   (1..max_size).each do |num|
  #     return distance(x, y, original_coords) if max_size == num
  #     case spiral[num]
  #     when :up
  #       y -= 1
  #     when :down
  #       y += 1
  #     when :left
  #       x -= 1
  #     when :right
  #       x += 1
  #     end
  #   end
  # end  
end
