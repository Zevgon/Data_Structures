require_relative '../linked_lists/doubly_linked_list/dll.rb'

class LRUCache
	def initialize(max)
		@max = max
		@list = DLL.new
		@hash_map = Hash.new
		@length = 0
	end

	def get(val)
		#0(1)
		if @hash_map[val]
			@list.promote(@hash_map[val])
		else
			@length += 1
			if @length > @max
				deleted_link = @list.pop
				@hash_map.delete(deleted_link.val)
			end
			new_link = Link.new(val)
			@hash_map[val] = new_link
			@list << new_link
		end
	end

	def each(&prc)
		@list.each{|el| prc.call(el)}
	end

	def show
		@list.show
	end

	alias_method :<<, :get
end
