#!/usr/bin/env ruby

def rules
  @rules ||= STDIN.read.split("\n").map{|r| parse_rule(r)}
end

def parse_rule(rule)
  pattern, output = rule.split("=>").map(&:strip)
  pattern = pattern.split("/").map(&:chars)
  output  = output.split("/").map(&:chars)

  patterns = []

  [pattern, hflip(pattern), vflip(pattern)].each do |p|
    patterns << p
    patterns << rotate(p)
    patterns << rotate(rotate(p))
    patterns << rotate(rotate(rotate(p)))
  end

  [patterns, output]
end

def print_image(i)
  i.each do |row|
    puts row.join
  end
  puts
end

def image
  @image ||= [
    ['.', '#', '.'],
    ['.', '.', '#'],
    ['#', '#', '#']
  ]
end

def split(input, by)
  row = col = 0
  squares = []
  while (row < input.length) do
    while (col < input[0].length) do
      square = []
      by.times do |r|
        square << input[row+r].slice(col,by)
      end
      squares << square
      col += by
    end
    row += by
    col = 0
  end
  squares
end

def merge(squares)
  return squares[0] if squares.count == 1

  size   = Math.sqrt(squares.count)
  output = []

  squares.each_slice(size).map do |squares|
    i = 0
    while(i < squares[0].count) do
      output << squares.map{|s| s[i]}.flatten
      i += 1
    end
  end
  output
end

def rotate(square)
  square.transpose.map(&:reverse)
end

def vflip(square)
  square.map(&:reverse)
end

def hflip(square)
  vflip(rotate(rotate(square)))
end

def transform(square)
  rules.each do |rule|
    return rule[1] if rule[0].include?(square)
  end
  puts "no match"
  square
end

def enhance
  squares = split(image, image.length % 2 == 0 ? 2 : 3)
  transformed_squares = squares.map do |square|
    transform(square)
  end
  @image = merge(transformed_squares)
end

if __FILE__ == $0
  5.times {|i| enhance }
  p image.flatten.select{|c| c == '#'}.count
end
