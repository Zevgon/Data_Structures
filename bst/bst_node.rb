class Node
	attr_accessor :val, :left, :right
	def initialize(val)
		@left = nil
		@right = nil
		@val = val
	end

	def childless?
		@left.nil? && @right.nil?
	end
end
