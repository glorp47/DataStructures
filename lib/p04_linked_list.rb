require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, nxt = nil, prv = nil)
    @key, @val, @next, @prev = key, val, nxt, prv
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def first=(link)
    @head = link
  end

  def last=(link)
    @tail = link
  end


  def empty?
    @head.val.nil? && @head.next.nil?
  end

  def get(key)
    current_place = @head
    until current_place.key == key || current_place.next.nil?
      current_place = current_place.next
    end
    current_place.key == key ? current_place.val : nil

  end

  def include?(key)
    current_place = @head
    until current_place.key == key || current_place.next.nil?
      current_place = current_place.next
    end
    current_place.key == key ? true : false
  end

  def insert(key, val)
    if empty?
      @head = Link.new(key, val)
      @tail = @head
    else
      current_place = @tail
      until current_place.prev == nil
        current_place = current_place.prev
      end
      current_place.prev = Link.new(key, val)
      @head = current_place.prev
    end
  end

  def remove(key)
    current_place = @head
    if current_place.key == key
      @head = @head.next
    else
      until current_place.next.key == key || current_place.next.nil?
        current_place = current_place.next
      end
      if current_place.next.key == key
        @tail = current_place.next if current_place.next.next.nil?
        current_place.next = current_place.next.next
        current_place.next.prev = current_place
      else
        nil
      end
    end
  end

  def each
    current_place = @head
    until current_place.nil?
      yield(current_place)
      current_place = current_place.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
