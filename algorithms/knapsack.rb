# Knapsack with dynamic programming and support for repetition
class Knapsack
  def initialize(items)
    @items = items
  end

  def pack(capacity, repetition = false)
    row = Array.new(capacity + 1, 0)
    sack = (@items.count + 1).times.map { row.dup }

    @items.each.with_index(1) do |item, i|
      (1..capacity).each do |b|
        previous = repetition ? sack[i] : sack[i - 1]

        sack[i][b] =
          if item[:weight] <= b
            [item[:value] + previous[b - item[:weight]], sack[i - 1][b]].max
          else
            sack[i - 1][b]
          end
      end
    end

    sack[@items.count][capacity]
  end
end

# Example usage:
#
# items = [
#   { value: 2, weight: 7 },
#   { value: 5, weight: 8 },
#   { value: 4, weight: 9 },
#   { value: 9, weight: 3 },
#   { value: 8, weight: 1 }
# ]
#
# knapsack = Knapsack.new(items)

# puts "NO REPETITION: #{knapsack.pack(ARGV[0].to_i)}"
# puts "REPETITION: #{knapsack.pack(ARGV[0].to_i, true)}"


# Simpler implementation of knapsack where repetition is permitted
class KnapsackRepeat
  def initialize(items)
    @items = items
  end

  def pack(capacity)
    sack = Array.new(capacity + 1, 0)

    sack.count.times do |b|
      @items.each do |item|
        if item[:weight] <= b
          sack[b] = [item[:value] + sack[b - item[:weight]], sack[b]].max
        end
      end
    end

    sack[-1]
  end
end

# Example usage:
#
# items = [
#   { value: 2, weight: 7 },
#   { value: 5, weight: 8 },
#   { value: 4, weight: 9 },
#   { value: 9, weight: 3 },
#   { value: 8, weight: 1 }
# ]
#
# knapsack = KnapsackRepeat.new(items)

# puts "REPETITION: #{knapsack.pack(ARGV[0].to_i)}"
