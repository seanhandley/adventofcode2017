#!/usr/bin/env ruby

def instructions
  @instructions ||= STDIN.read.split("\n").map{|i| parse_instruction(i)}
end

def parse_instruction(i)
  instruction, *args = i.split
  args = args.map{|a| Integer(a) rescue a }
  [instruction, args]
end

trap "SIGINT" do
  debug
end

def debug
  p $sends.length
  p $queue_0.length
  p $queue_1.length
end

def execute(id, other, instructions)
  current_instruction = 0
  registers = {"p" => id}

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
      val = args[0].is_a?(Integer) ? args[0] : registers[args[0]]
      if id == 0
        $queue_1.push val
      else
        $queue_0.push val
      end
      $sends.push(1) if id == 1
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
      if id == 0
        registers[args[0]] = $queue_0.pop
      else
        registers[args[0]] = $queue_1.pop
      end
    when "jgz"
      if args[0].is_a? Integer
        if args[0] > 0
          if args[1].is_a? Integer
            current_instruction += args[1]
          else
            current_instruction += registers[args[1]]
          end
          next
        end
      else
        if registers[args[0]] > 0
          if args[1].is_a? Integer
            current_instruction += args[1]
          else
            current_instruction += registers[args[1]]
          end
          next
        end
      end
    end
    current_instruction += 1
  end
end

$queue_0 = Queue.new
$queue_1 = Queue.new
$sends   = Queue.new

def multi_execute
  a = Thread.new { sleep 1; execute(0, 1, instructions.dup) }
  b = Thread.new { sleep 1; execute(1, 0, instructions.dup) }
  loop {a; b}
  # [a,b].each &:join
ensure
  debug
end

multi_execute
