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
    link = @map[key]
    if link
      update_link!(link)
      link.val
    else
      val = @prc.call(key)
      link = @store.append(key, val)
      @map[key] = link
      eject! if count > @max
      val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    if link
      link.remove
      @store.append(link.key, link)
    end
  end

  def eject!
    link = @store.first.remove
    @map.delete(link.key)
  end
end
