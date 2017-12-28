#!/usr/bin/env ruby

@highest = 0

def instructions
  @instructions ||= STDIN.read.split("\n")
end

def registers
  @registers ||= {}
end

def parse_and_execute(instruction)
  a, b = instruction.split("if")
  register, operation, value  = a.strip.split
  cond_reg, cond_op, cond_val = b.strip.split

  if (registers[cond_reg] ||= 0).send(cond_op.to_sym, cond_val.to_i)
    registers[register] ||= 0
    case operation
    when "dec"
      registers[register] -= value.to_i
    when "inc"
      registers[register] += value.to_i
    end
    @highest = [registers[register], @highest].max
  end
end

def run
  instructions.each do |instruction|
    parse_and_execute(instruction)
  end
  @highest
end

if __FILE__ == $0
  p run
end