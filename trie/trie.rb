require_relative 'trie_node.rb'
class Trie
	def initialize
		@root = TrieNode.new(nil)
	end

	def insert(str)
		current_node = @root
		idx = 0
		while idx < str.length
			if current_node.has_child?(str[idx]) && idx == str.length - 1
				current_node[str[idx]].set_end
				break
			elsif current_node.has_child?(str[idx])
				current_node = current_node[str[idx]]
				idx += 1
				next
			else
				is_end = idx == str.length - 1
				current_node.add_child(str[idx], is_end)
				current_node = current_node[str[idx]]
			end
			idx += 1
		end

		str
	end

	alias_method :<<, :insert

	def include?(str)
		current_node = @root
		idx = 0
		while idx < str.length
			unless current_node.has_child?(str[idx])
				return false
			else
				current_node = current_node[str[idx]]
			end
			idx += 1
		end

		true
	end

	def include_exactly?(str)
		current_node = @root
		idx = 0
		while idx < str.length
			unless current_node.has_child?(str[idx])
				return false
			else
				current_node = current_node[str[idx]]
			end
			idx += 1
		end
		current_node.is_end
	end
end
