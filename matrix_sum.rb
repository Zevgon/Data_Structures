class MatrixSum
	def initialize(size)
		@size = size
		@store = Array.new(size) {Array.new}
		@length = 0
	end

	def [](pos)
		i, j = pos
		decontaminate(i, j)
	end

	def insert(n)
		if n.is_a?(Array)
			n.each do |number|
				insert_helper(number)
			end
		else
			insert_helper(n)
		end
	end

	def insert_helper(n)
		row_num = @length / @size
		sum = n
		idx = 0
		until @store[row_num][idx] == nil
			sum += @store[row_num][idx]
			idx += 1
		end
		@length += 1
		@store[row_num][idx] = sum
	end

	def sum_of_square(top_left, bottom_right)
		top_i, top_j = top_left
		bottom_i, bottom_j = bottom_right
		sum = 0
		while bottom_i >= top_i
			sum += @store[bottom_i][bottom_j]
			idx = 0
			until idx == top_j
				contaminant = @store[bottom_i][idx]
				sum -= contaminant * (top_j - idx + 1)
				idx += 1
			end
			bottom_i -= 1
		end

		sum
	end

	def decontaminate(row, col)
		contaminated = @store[row][col]
		idx = 0
		while idx < col
			contaminant = @store[row][idx]
			contaminated -= contaminant
			idx += 1
		end

		contaminated
	end

	alias_method :<<, :insert

	def to_s
		p @store
	end
end


m = MatrixSum.new(3)
m << [1, 2, 3, 4, 5, 6, 7, 8, 9]
m.to_s
p m.sum_of_square([0, 0], [1, 1])
p m[[1, 1]]
