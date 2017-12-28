#! /usr/bin/env elixir

Code.require_file("redistribute.ex", __DIR__)

{_, redistributions} = Redistribute.execute()
redistributions |> IO.puts()
