require 'colorize'
class Cache
  attr_reader :slots_and_data
  def initialize(slots)
    @slots = slots
    @slots_and_data = {}
    (0..slots - 1).step do | n |
      @slots_and_data[n] = "available"
    end
    @meter = CacheMeter.new
  end

  def full?
    ! @slots_and_data.values.any? do | e |
      e == "available"
    end
  end

  def validate_push(content)
    raise "Invalid Content" if content == "" || content == "available"
  end

  def fetch(content)
    raise "Subclass Responsibility"
  end

  def performance
    raise "Subclass Responsibility"
  end

  def include?(content)
    @slots_and_data.value?(content)
  end
end

class CacheFIFO < Cache
  def initialize(slots)
    super
    @to_replace = 0
  end

  def fetch(content)
    validate_push(content)
    if include? content
      @meter.hit
    else
      @slots_and_data[@to_replace % @slots] = content
      @to_replace += 1
      @meter.miss
    end
  end

  def performance
    @meter.show_performance("FIFO")
  end
end

class CacheRandom < Cache
  def fetch(content)
    validate_push(content)
    if include? content
      @meter.hit
    else if full?
           push_in(content, random_slot)
           @meter.miss
         else
           push_in(content, free_slot)
           @meter.miss
         end
    end
  end

  def random_slot
    rand(@slots)
  end

  def free_slot
    @slots_and_data.find_index do |_, content|
      content == "available"
    end
  end

  def push_in(content, index)
    @slots_and_data[index] = content
  end

  def performance
    @meter.show_performance("Random")
  end
end

class CacheMeter
  attr_reader :misses, :hits
  def initialize
    @misses = 0
    @hits = 0
  end

  def miss
    @misses += 1
  end

  def hit
    @hits += 1
  end

  def show_performance(memory)
    puts "--- Performance of #{memory}"
    puts "hits: #{@hits.to_s.green}"
    puts "misses: #{@misses.to_s.red}"
    puts "average: #{@hits.to_f / (@hits + @misses)}"
  end
end
