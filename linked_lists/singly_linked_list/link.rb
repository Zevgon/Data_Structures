class Link
	attr_accessor :next
	attr_reader :val
	def initialize(val)
		@val = val
		@next = nil
	end
end
