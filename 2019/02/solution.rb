class Intcode
  attr_accessor :instructions

  def initialize(instructions, override)
    @instructions = instructions
    manual_init(override)
  end

  def self.call(instructions, override)
    self.new(instructions, override).run_computer
  end

  def manual_init(setup)
    setup.each do |k, v|
      instructions[k] = v
    end
  end

  def run_computer
    output = instructions.clone

    for i in (0..instructions.size - 1).step(4) do
      opcode = instructions[i]
      operate_add(instructions[i + 1], instructions[i + 2], instructions[i + 3]) if opcode == 1
      operate_multiply(instructions[i + 1], instructions[i + 2], instructions[i + 3]) if opcode == 2
      return instructions if opcode == 99
    end

    instructions
  end

  def operate_multiply(term_a, term_b, output_address)
    instructions[output_address] = instructions[term_a] * instructions[term_b]
  end

  def operate_add(term_a, term_b, output_address)
    instructions[output_address] = instructions[term_a] + instructions[term_b]
  end
end

def part1
  data = File.read("data.txt").chomp.split(",").map(&:to_i)
  x = Intcode.call(data, {1 => 12, 2 => 2})
  p x[0]
end

def part2
  data = File.read("data.txt").chomp.split(",").map(&:to_i)
  (0..99).each do |noun|
    (0..99).each do |verb|
      x = Intcode.call(data.clone, {1 => noun, 2 => verb})
      if x[0] == 19690720
        puts "#{noun}, #{verb}"
        return
      end
    end
  end
end

part1
puts 
part2
