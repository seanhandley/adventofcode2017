#!/usr/bin/env elixir

defmodule Jump do
  def program do
    IO.read(:stdio,:all)
    |> String.split
    |> Enum.map(&(String.to_integer(&1)))
    |> Stream.with_index
    |> Enum.map(fn {v,i} -> {i, v} end)
    |> Map.new
  end

  def execute(program, pos \\ 0, step \\ 0)
  def execute(program, pos, step) do
    case Map.fetch(program, pos) do
      {:ok, val} ->
        program
        |> Map.update(pos, 0, &(
            cond do
              &1 > 2 -> &1 - 1
              &1 < 3 -> &1 + 1
            end
          )
        )
        |> execute(pos + val, step + 1)
      :error -> step
    end
  end
end

Jump.program
|> Jump.execute
|> IO.inspect