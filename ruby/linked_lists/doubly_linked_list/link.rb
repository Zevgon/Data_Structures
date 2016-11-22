class Link
	attr_accessor :next, :prev
	attr_reader :val
	def initialize(val)
		@val = val
		@next = nil
		@prev = nil
	end
end
