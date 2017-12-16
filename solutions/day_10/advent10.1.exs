#!/usr/bin/env elixir

Code.require_file "knot_hash.ex", __DIR__

{list, _, _} = KnotHash.starting_list |> KnotHash.hash_step
{_, x} = Enum.fetch(list, 0)
{_, y} = Enum.fetch(list, 1)
x * y |> IO.puts
