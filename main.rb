require 'colorize'
require_relative './cache'
def execute_with(program, cache)
  program.each do | content |
    cache.fetch(content)
  end
end
puts "--- Cache Performance Test".blue

mi_cache_fifo = CacheFIFO.new(4)
mi_cache_random = CacheRandom.new(4)
programa = [
  "Inst 0", "Inst 1", "Inst 2", "Inst 2", "Inst 3",
  "Inst 3", "Inst 4", "Inst 1", "Inst 2", "Inst 5",
  "Inst 0", "Inst 1", "Inst 2", "Inst 2", "Inst 3",
  "Inst 3", "Inst 4", "Inst 1", "Inst 2", "Inst 5",
  "Inst 0", "Inst 1", "Inst 2", "Inst 2", "Inst 3",
  "Inst 3", "Inst 4", "Inst 1", "Inst 2", "Inst 5",
  "Inst 0", "Inst 1", "Inst 2", "Inst 2", "Inst 3",
  "Inst 3", "Inst 4", "Inst 1", "Inst 2", "Inst 5",
  "Inst 0", "Inst 1", "Inst 2", "Inst 2", "Inst 3",
  "Inst 3", "Inst 4", "Inst 1", "Inst 2", "Inst 5",
  "Inst 0", "Inst 1", "Inst 2", "Inst 2", "Inst 3",
  "Inst 3", "Inst 4", "Inst 1", "Inst 2", "Inst 5",
  "Inst 0", "Inst 1", "Inst 2", "Inst 2", "Inst 3",
  "Inst 3", "Inst 4", "Inst 1", "Inst 2", "Inst 5",
  "Inst 0", "Inst 1", "Inst 2", "Inst 2", "Inst 3",
  "Inst 3", "Inst 4", "Inst 1", "Inst 2", "Inst 5",
]

execute_with(programa, mi_cache_fifo)
puts mi_cache_fifo.performance

execute_with(programa, mi_cache_random)
puts mi_cache_random.performance