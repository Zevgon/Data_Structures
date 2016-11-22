require_relative 'link.rb'

class SLL
	def initialize(val)
		@head = Link.new(val)
		@tail = @head
		@length = 0
	end

	def insert(val)
		#0(1)
		@length += 1
		@tail.next = Link.new(val)
		@tail = @tail.next
	end

	alias_method :<<, :insert

	def each(&prc)
		#0(n)
		link = @head
		while link
			prc.call(link.val)
			link = link.next
		end
	end

	def show
		#0(n)
		vals = []
		each do |val|
			vals << val
		end

		vals
	end

	def reverse!
		return if @tail == @head
		@tail, @head = @head, @tail
		rev_rec(@tail)
	end

	def rev_rec(tail)
		#0(n)
		if tail.next == @head
			@head.next = tail
			tail.next = nil
			tail
		else
			prev = rev_rec(tail.next)
			prev.next = tail
			tail.next = nil
			tail
		end
	end

	def include?(val)
		#0(n)
		each do |included_val|
			return true if included_val == val
		end

		false
	end
end
