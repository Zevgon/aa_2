class PolyTreeNode
	attr_reader :value, :parent
	attr_accessor :children
	def initialize(value)
		@value = value
		@parent = nil
		@children = []
	end

	alias_method :val, :value

	def parent=(parent)
		if @parent
			@parent.children.delete(self)
		end
		@parent = parent
		if parent
			parent.children << self unless parent.children.include?(self)
		end
	end

	def add_child(child)
		@children << child
		child.parent = self
	end

	def remove_child(child)
		raise 'Not a child' unless child.parent
		@children.delete(child)
		child.parent = nil
	end

	def dfs(val)
		return self if self.value == val
		self.children.each do |child|
			node = child.dfs(val)
			return node if node && node.val == val
		end

		nil
	end

	def bfs(val)
		q = [self]
		until q.empty?
			node = q.shift
			return node if node.value == val
			q += node.children
		end

		nil
	end
end
