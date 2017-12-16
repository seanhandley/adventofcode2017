#!/usr/bin/env ruby

class Generator
  attr_reader :value, :factor

  def initialize(value, factor)
    @value  = value
    @factor = factor
  end

  def generate
    @value = (value * factor) % divisor
  end

  def divisor
    2_147_483_647
  end
end

class Judge
  attr_reader :a, :b

  ITERATIONS = 40_000_000
  A_FACTOR   = 16_807
  B_FACTOR   = 48_271
  MASK       = (("0" * 16) + ("1" * 16)).to_i(2)

  def initialize
    a_start, b_start = STDIN.read.split("\n").map{|line| line.scan(/\d+/)[0].to_i}
    @a = Generator.new(a_start, A_FACTOR)
    @b = Generator.new(b_start, B_FACTOR)
  end

  def dump
    p a.value.to_s(2).rjust(32, '0')
    p b.value.to_s(2).rjust(32, '0')
    puts
  end

  def judge
    ITERATIONS.times.select do
      [a,b].each(&:generate)
      (a.value & MASK) == (b.value & MASK)
    end.count
  end
end

p Judge.new.judge
