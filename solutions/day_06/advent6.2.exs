#! /usr/bin/env elixir

Code.require_file("redistribute.ex", __DIR__)

{memory, _} = Redistribute.execute()

{_, redistributions} = Redistribute.execute(memory, MapSet.new(memory))
redistributions |> IO.puts()
