require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % @store.length].include?(key)
  end

  def set(key, val)
    resize! if @count > @store.length
    if @store[key.hash % @store.length].include?(key)
      @store[key.hash % @store.length].remove(key)
    end
    @store[key.hash % @store.length].insert(key, val)
    @count += 1
  end

  def get(key)
    @store[key.hash % @store.length].include?(key) ?
    @store[key.hash % @store.length].get(key) : nil
  end

  def delete(key)
    if @store[key.hash % @store.length].include?(key)
      @store[key.hash % @store.length].remove(key)
      @count -= 1
    end
  end

  def each
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new(@store.length * 2) { LinkedList.new }
    new_length = @store.length * 2
    @store.each do |list|
      list.each do |link|
        new_array[link.key.hash % new_length].insert(link.key, link.val)
      end
    end

    @store = new_array

  end

  def bucket(key)
    self[link.key.hash % new_array.length]
  end
end
