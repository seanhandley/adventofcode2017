#!/usr/bin/env ruby

require_relative "./advent12.1"

@groups = Set.new
@count  = 0

trap "SIGINT" do
  puts
  puts @groups.count
  puts @count
end

def find_groups
  input.keys.each do |key|
    @count = key
    @groups << find_group(key)
  end
  @groups
end

if __FILE__ == $0
  p find_groups.count
end
