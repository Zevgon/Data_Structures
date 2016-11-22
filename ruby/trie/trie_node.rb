class TrieNode
	attr_reader :is_end
	def initialize(val, is_end = false)
		@val = val
		@children = Hash.new
		@is_end = is_end
	end

	def has_child?(val)
		@children.has_key?(val)
	end

	def add_child(val, is_end)
		@children[val] = TrieNode.new(val, is_end)
	end

	def [](val)
		@children[val]
	end

	def set_end
		@is_end = true
	end
end
