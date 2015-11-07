require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    return_val = nil
    if @map.include?(key)
      update_link!(@map[key])
      return_val = @map[key].val
    else
      @store.insert(key, calc!(key))
      @map[key] = @store.head
      return_val = @map[key].val
      eject! if count > @max
    end
      return_val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
  end

  def update_link!(link)
        @store.last = link.prev if link.next.nil?
        link.next.prev = link.prev unless link.next.nil?
        link.prev.next = link.next unless link.prev.nil?
        @store.first.prev = link unless @store.first.nil?
        @store.first = link
  end

  def eject!
    least_used_key = @store.first.key
    @store.remove(least_used_key)
    @map.delete(least_used_key)
  end
end
