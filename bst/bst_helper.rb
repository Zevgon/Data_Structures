module BSTHelper
	def delete(root, val)
		parent = BST.find_parent(root, val)
		if parent
			node_to_delete = parent.left && parent.left.val == val ? parent.left : parent.right
		else
			node_to_delete = root
		end

		if node_to_delete == root && node_to_delete.childless?
			node_to_delete.val = nil
		elsif node_to_delete.childless?
			BST.delete_child(parent, node_to_delete)
		elsif node_to_delete.left
			BST.left_delete(node_to_delete)
		else
			BST.right_delete(node_to_delete)
		end

		node_to_delete
	end

	def delete_child(parent, child)
		if parent.left == child
			parent.left = nil
		else
			parent.right = nil
		end
	end

	def find_parent(node, val)
		return nil if node.val == val
		while node
			return node if node.left && node.left.val == val
			return node if node.right && node.right.val == val
			if val <= node.val
				node = node.left
			else
				node = node.right
			end
		end

		nil
	end

	def left_delete(node_to_delete)
		plm = BST.parent_of_left_max(node_to_delete)
		if plm == node_to_delete
			node_to_delete.val = node_to_delete.left.val
			node_to_delete.left = node_to_delete.left.left
		else
			node_to_delete.val = plm.right.val
			plm.right = plm.right.left
		end
	end

	def max(node)
		return nil unless node && node.val
		while node.right
			node = node.right
		end

		node
	end

	def min(node)
		return nil unless node && node.val
		while node.left
			node = node.left
		end

		node
	end

	def parent_of_left_max(root)
		walker = root.left
		return root unless walker && walker.right
		while walker.right && walker.right.right
			walker = walker.right
		end

		walker
	end

	def parent_of_right_min(root)
		walker = root.right
		return root unless walker && walker.left
		while walker.left && walker.left.left
			walker = walker.left
		end

		walker
	end

	def right_delete(node_to_delete)
		prm = BST.parent_of_right_min(node_to_delete)
		if prm == node_to_delete
			node_to_delete.val = node_to_delete.right.val
			node_to_delete.right = node_to_delete.right.right
		else
			node_to_delete.val = prm.left.val
			prm.left = prm.left.right
		end
	end
end
