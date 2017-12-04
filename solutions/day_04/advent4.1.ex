#!/usr/bin/env elixir

IO.read(:stdio, :all)
|> String.split("\n")
|> Enum.map(&(&1 |> String.split))
|> Enum.filter(fn(line) ->
  line
  |> Enum.uniq
  |> length == line |> length
end)
|> length
|> IO.puts
