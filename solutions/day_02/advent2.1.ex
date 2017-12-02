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

  def calculate_checksum(input) do
    Enum.map(input, fn (row) ->
      Enum.max(row) - Enum.min(row)
    end)
    |> Enum.sum 
  end
end

Checksum.fetch_input
|> Checksum.calculate_checksum
|> IO.inspect 

