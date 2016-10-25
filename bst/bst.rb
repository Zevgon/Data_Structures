require_relative 'bst_helper.rb'
require_relative 'bst_node.rb'

class BST
	extend BSTHelper

	attr_reader :root
	def initialize
		@root = Node.new(nil)
	end

	def construct_arr(root)
		return [] unless root && root.val
		prev_left = construct_arr(root.left)
		prev_right = construct_arr(root.right)
		[root.val].concat(prev_left).concat(prev_right)
	end

	def delete(val)
		BST.delete(@root, val)
	end

	def find(val)
		walker = @root
		return nil unless @root.val
		while walker
			return walker if walker.val == val
			val < walker.val ? walker = walker.left : walker = walker.right
		end

		nil
	end

	def find_parent(val)
		BST.find_parent(@root, val)
	end

	def insert(val)
		unless @root.val
			@root.val = val
			return
		end
		walker = @root
		while true
			if val <= walker.val
				if walker.left
					walker = walker.left
				else
					walker.left = Node.new(val)
					break
				end
			elsif val > walker.val
				if walker.right
					walker = walker.right
				else
					walker.right = Node.new(val)
					break
				end
			end
		end

		@root
	end
	alias_method :<<, :insert

	def to_s
		p construct_arr(@root)
	end

end

b = BST.new
b << 5
b << 1
b << 8
b << 10
b << 6
b.delete(5)
p b.find_parent(8)
b.to_s
