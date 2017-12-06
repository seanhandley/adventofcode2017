#!/usr/bin/env elixir

Code.require_file "captcha.exs", __DIR__

input  = Captcha.fetch_input
offset = 1

input
|> Captcha.calculate_captcha(offset)
|> IO.puts
