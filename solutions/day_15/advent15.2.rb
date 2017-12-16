#!/usr/bin/env ruby

class Generator
  attr_reader :value, :factor, :multiple

  def initialize(value, factor, multiple)
    @value    = value
    @factor   = factor
    @multiple = multiple
  end

  def generate
    while(do_generate) do
      return value if value % multiple == 0
    end
  end

  private

  def do_generate
    @value = (value * factor) % divisor
  end

  def divisor
    2_147_483_647
  end
end

class Judge
  attr_reader :a, :b

  ITERATIONS = 5_000_000
  A_FACTOR   = 16_807
  A_MULTIPLE = 4
  B_MULTIPLE = 8
  B_FACTOR   = 48_271
  MASK       = (("0" * 16) + ("1" * 16)).to_i(2)

  def initialize
    a_start, b_start = STDIN.read.split("\n").map{|line| line.scan(/\d+/)[0].to_i}
    @a = Generator.new(a_start, A_FACTOR, A_MULTIPLE)
    @b = Generator.new(b_start, B_FACTOR, B_MULTIPLE)
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
