#!/usr/bin/env elixir

defmodule Checksum do
  def fetch_input do
    IO.read(:stdio, :all)
    |> String.split("\n")
    |> Enum.map(fn (row)->
      String.split(row, "\t")
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(fn ({x,_}) ->
        x
      end)
    end)
  end

  def combine(collection, k) when is_integer(k) and k >= 0 do
    list = Enum.to_list(collection)
    list_length = Enum.count(list)
    if k > list_length do
      raise Enum.OutOfBoundsError
    else
      do_combine(list, list_length, k, [], [])
    end
  end

  defp do_combine(_list, _list_length, 0, _pick_acc, _acc), do: [[]]
  defp do_combine(list, _list_length, 1, _pick_acc, _acc), do: list |> Enum.map(&([&1])) # optimization
  defp do_combine(list, list_length, k, pick_acc, acc) do
    list
    |> Stream.unfold(fn [h | t] -> {{h, t}, t} end)
    |> Enum.take(list_length)
    |> Enum.reduce(acc, fn {x, sublist}, acc ->
      sublist_length = Enum.count(sublist)
      pick_acc_length = Enum.count(pick_acc)
      if k > pick_acc_length + 1 + sublist_length do
        acc # insufficient elements in sublist to generate new valid combinations
      else
        new_pick_acc = [x | pick_acc]
        new_pick_acc_length = pick_acc_length + 1
        case new_pick_acc_length do
          ^k -> [new_pick_acc | acc]
          _  -> do_combine(sublist, sublist_length, k, new_pick_acc, acc)
        end
      end
    end)
  end

  def calculate_checksum(input) do
    Enum.flat_map(input, fn (row) ->
      Enum.map(Checksum.combine(row, 2), fn (p) ->
        [y, x] = Enum.sort(p)
        if rem(x, y) == 0 do
          div(x, y)
        else
          0
        end
      end)
    end)
    |> Enum.sum 
  end
end

Checksum.fetch_input
|> Checksum.calculate_checksum
|> IO.inspect 

