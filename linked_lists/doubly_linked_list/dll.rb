require 'byebug'
require_relative 'link.rb'

class DLL
	def initialize
		@head = Link.new(nil)
		@tail = Link.new(nil)
		@head.next = @tail
		@tail.prev = @head
	end

	def insert(val_or_link)
		#0(1)
		if val_or_link.is_a?(Link)
			new_link = val_or_link
		else
			new_link = Link.new(val_or_link)
		end
		new_link.next = @head.next
		new_link.prev = @head
		@head.next.prev = new_link
		@head.next = new_link
	end

	alias_method :<<, :insert

	def each(&prc)
		#0(n)
		link = @head.next
		until link == @tail || link.nil?
			prc.call(link.val)
			link = link.next
		end
	end

	def show
		#0(n)
		vals = []
		each{|val| vals << val}
		p vals
	end

	def reverse!
		#0(n)
		link = @head.next
		until link == @tail
			link.next, link.prev = link.prev, link.next
			link = link.prev
		end
		@head.next.next = @tail
		@tail.prev.prev = @head
		@head.next, @tail.prev = @tail.prev, @head.next
		@head.prev = nil
		@tail.next = nil
	end

	def remove(link)
		#0(1)
		link.prev.next = link.next
		link.next.prev = link.prev
		link
	end

	def promote(link)
		link = remove(link)
		insert(link)
	end

	def pop
		popped_item = @tail.prev
		@tail.prev.prev.next = @tail
		@tail.prev = @tail.prev.prev
		popped_item
	end
end
