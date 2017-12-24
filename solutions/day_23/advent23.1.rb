#!/usr/bin/env ruby

def instructions
  @instructions ||= STDIN.read.split("\n").map{|i| parse_instruction(i)}
end

def parse_instruction(i)
  instruction, *args = i.split
  args = args.map{|a| Integer(a) rescue a }
  [instruction, args]
end

def registers
  @registers ||= {}
end


trap "SIGINT" do
  puts @registers
  puts @mult
end

def execute
  mult = 0
  current_instruction = 0
  while current_instruction < instructions.length-1
    instruction = instructions[current_instruction]
    args = instruction[1]
    args.each do |arg|
      unless arg.is_a?(Integer)
        registers[arg] ||= 0
      end
    end

    case instruction[0]
    when "set"
      if args[1].is_a? Integer
        registers[args[0]] = args[1]
      else
        registers[args[0]] = registers[args[1]]
      end
    when "sub"
      if args[1].is_a? Integer
        registers[args[0]] = registers[args[0]] - args[1]
      else
        registers[args[0]] = registers[args[0]] - registers[args[1]]
      end
    when "mul"
      if args[1].is_a? Integer
        registers[args[0]] = registers[args[0]] * args[1]
      else
        registers[args[0]] = registers[args[0]] * registers[args[1]]
      end
      mult += 1
    when "jnz"
      if args[0].is_a? Integer
        if args[0] != 0
          current_instruction += args[1]
          next
        end
      else
        if registers[args[0]] != 0
          current_instruction += args[1] 
          next
        end
      end
    end
    current_instruction += 1
  end
  mult
end

p execute
