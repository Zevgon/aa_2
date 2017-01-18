class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count
  include Enumerable

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    if i < 0
      i = @count + i
    end
    return nil unless i.between?(0, capacity - 1)
    @store[i]
  end

  def []=(i, val)
    if i < 0
      i = @count + i
    end
    resize! if i >= capacity
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    resize! if @count == capacity
    @store[count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == capacity
    i = @count
    while i > 0
      @store[i] = @store[i - 1]
      i -= 1
    end
    @store[0] = val
  end

  def pop
    return nil if @count == 0
    i = @count - 1
    el = @store[i]
    if el
      @store[i] = nil
      @count -= 1
      el
    end
  end

  def shift
    return nil if @count == 0
    el = @store[0]
    i = 1
    while i < @count
      @store[i - 1] = @store[i]
      i += 1
    end
    @store[i - 1] = nil
    @count -= 1
    el
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each(&prc)
    i = 0
    while i < @count
      prc.call(@store[i])
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    each_with_index do |el, idx|
      return false unless el == other[idx]
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    old_store = @store
    @store = StaticArray.new(capacity * 2)
    idx = 0
    while idx < old_store.length
      @store[idx] = old_store[idx]
      idx += 1
    end
  end
end
