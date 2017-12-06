#!/usr/bin/env elixir

Code.require_file "redistribute.exs", __DIR__

{memory, _} = Redistribute.memory |> Redistribute.execute

{_, redistributions} = Redistribute.execute(memory, MapSet.new(memory))
redistributions |> IO.puts
