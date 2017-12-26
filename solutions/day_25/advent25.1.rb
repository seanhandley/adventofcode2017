#!/usr/bin/env ruby

@steps = 0
@max_steps = 12_656_374

trap "SIGINT" do
  p @steps
end

class InfiniteTape
  attr_reader :tape, :current_position

  def initialize
    @tape = []
    @current_position = 0
  end

  def move(direction, n)
    direction == :left ? move_left(n) : move_right(n)
  end

  def read
    @tape[@current_position] ||= 0
  end

  def write(value)
    @tape[@current_position] = value
  end

  def to_s
    @tape
  end

  private

  def move_left(n)
    move_by = (@current_position - n)
    if move_by < 0
      move_by.abs.times { @tape.unshift(0) }
      @current_position = 0
    else
      @current_position -= n
    end
  end

  def move_right(n)
    @current_position += n
  end
end

class TuringMachine
  attr_reader :tape

  def initialize
    @tape = InfiniteTape.new
    @state = "a"
  end

  def tick
    case @state
    when "a"
      if @tape.read == 0
        @tape.write 1
        @tape.move(:right, 1)
        @state = 'b'
      else
        @tape.write 0
        @tape.move(:left, 1)
        @state = 'c'
      end
    when "b"
      if @tape.read == 0
        @tape.write 1
        @tape.move(:left, 1)
        @state = 'a'
      else
        @tape.write 1
        @tape.move(:left, 1)
        @state = 'd'
      end     
    when "c"
      if @tape.read == 0
        @tape.write 1
        @tape.move(:right, 1)
        @state = 'd'
      else
        @tape.write 0
        @tape.move(:right, 1)
        @state = 'c'
      end
    when "d"
      if @tape.read == 0
        @tape.write 0
        @tape.move(:left, 1)
        @state = 'b'
      else
        @tape.write 0
        @tape.move(:right, 1)
        @state = 'e'
      end
    when "e"
      if @tape.read == 0
        @tape.write 1
        @tape.move(:right, 1)
        @state = 'c'
      else
        @tape.write 1
        @tape.move(:left, 1)
        @state = 'f'
      end
    when "f"
      if @tape.read == 0
        @tape.write 1
        @tape.move(:left, 1)
        @state = 'e'
      else
        @tape.write 1
        @tape.move(:right, 1)
        @state = 'a'
      end
    end
  end
end

@tm = TuringMachine.new
@max_steps.times { @tm.tick; @steps += 1 }
p @tm.tape.tape.compact.reduce :+
