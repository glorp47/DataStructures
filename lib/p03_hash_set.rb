require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count += 1
    resize! if @count > @store.length
    @store[num.hash % @store.length] << num
  end

  def remove(num)
  @count -= 1
  @store[num.hash % @store.length].delete(num)
  end

  def include?(num)
    @store[num.hash % @store.length].include?(num)
  end

  private

  def [](num)
    @store[num.hash % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new(@store.length * 2) {Array.new}
    @store.each do |bucket|
      bucket.each do |num|
        new_array[num.hash % new_array.length] << num
      end
    end
    @store = new_array
  end

end
