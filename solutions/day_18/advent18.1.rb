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

def last_sound
  @last_sound
end

trap "SIGINT" do
  puts @registers
  puts @last_sound
end

def execute
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
    when "snd"
      if args[0].is_a? Integer
        last_sound = args[0]
      else
        last_sound = registers[args[0]]
      end
    when "set"
      if args[1].is_a? Integer
        registers[args[0]] = args[1]
      else
        registers[args[0]] = registers[args[1]]
      end
    when "add"
      if args[1].is_a? Integer
        registers[args[0]] = registers[args[0]] + args[1]
      else
        registers[args[0]] = registers[args[0]] + registers[args[1]]
      end
    when "mul"
      if args[1].is_a? Integer
        registers[args[0]] = registers[args[0]] * args[1]
      else
        registers[args[0]] = registers[args[0]] * registers[args[1]]
      end
    when "mod"
      if args[1].is_a? Integer
        registers[args[0]] = registers[args[0]] % args[1]
      else
        registers[args[0]] = registers[args[0]] % registers[args[1]]
      end
    when "rcv"
      return last_sound if registers[args[0]] != 0
    when "jgz"
      if args[0].is_a? Integer
        if args[0] > 0
          current_instruction += args[1]
          next
        end
      else
        if registers[args[0]] > 0
          current_instruction += args[1] 
          next
        end
      end
    end
    current_instruction += 1
  end
end

p execute
