items = [
  { value: 2, weight: 7 },
  { value: 5, weight: 8 },
  { value: 4, weight: 9 },
  { value: 9, weight: 3 },
  { value: 8, weight: 1 }
]

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

knapsack = Knapsack.new(items)

puts "NO REPETITION: #{knapsack.pack(ARGV[0].to_i)}"
puts "REPETITION: #{knapsack.pack(ARGV[0].to_i, true)}"
