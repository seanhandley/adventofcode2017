#!/usr/bin/env elixir

Code.require_file "redistribute.exs", __DIR__

{_, redistributions} = Redistribute.memory |> Redistribute.execute
redistributions |> IO.puts
