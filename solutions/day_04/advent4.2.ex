#!/usr/bin/env elixir

IO.read(:stdio, :all)
|> String.split("\n")
|> Enum.map(&(&1 |> String.split))
|> Enum.map(fn (line) ->
  Enum.map(line, fn (word) ->
    word
    |> to_charlist
    |> Enum.sort
    |> List.to_string
  end)
end)
|> Enum.filter(fn(line) ->
  line
  |> Enum.uniq
  |> length == line |> length
end)
|> length
|> IO.puts
