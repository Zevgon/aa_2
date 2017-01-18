class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    return unless @prev && @next
    @prev.next = @next
    @next.prev = @prev
    @next = nil
    @prev = nil
    self
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return @head.next unless empty?
  end

  def last
    return @tail.prev unless empty?
  end

  def empty?
    @head.next == @tail
  end

  def get_node(key)
    each do |node|
      return node if node.key == key
    end
    nil
  end

  def get(key)
    each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    link = Link.new(key, val)
    link.next = @tail
    link.prev = @tail.prev
    @tail.prev.next = link
    @tail.prev = link
    link
  end

  def update(key, val)
    node = get_node(key)
    if node
      node.val = val
    end
  end

  def remove(key)
    node = get_node(key)
    if node
      node.remove
    end
  end

  def each(&prc)
    node = @head.next
    while node != @tail
      prc.call(node)
      node = node.next
    end
  end

  def each_with_index(&prc)
    node = @head.next
    idx = 0
    while node != @tail
      prc.call(node, idx)
      idx += 1
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
