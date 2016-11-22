class QueueHash
	attr_reader :num_uniqs, :last_oldest_val
	def initialize(max)
		@queue = []
		@hash = Hash.new(0)
		@max = max
		@num_uniqs = 0
		@last_oldest_val = nil
	end

	def [](val)
		@hash[val]
	end

	def first
		@queue.first
	end

	def length
		@queue.length
	end

	def enqueue(val)
		@num_uniqs += 1 if @hash[val] == 0
		@hash[val] += 1
		@queue << val
		dequeue if @queue.length > @max
	end

	alias_method :<<, :enqueue

	def dequeue
		return if @queue.empty?
		oldest_val = @queue.shift
		@hash[oldest_val] -= 1
		@num_uniqs -= 1 if @hash[oldest_val] == 0
		@last_oldest_val = oldest_val
	end

	def matches?(other_hash, val)
		@hash[val] == other_hash[val]
	end

	def show
		p @queue
	end
end

def find_anagrams(s, p)
  qh = QueueHash.new(p.length)
  ph = Hash.new(0)
  num_uniqs = 0
  answer = []

  p.each_char do |char|
    if ph[char] == 0
      num_uniqs += 1
    end
    ph[char] += 1
  end

  tracker = 0
  s.each_char.with_index do |char, idx|
		tracker -= 1 if qh.matches?(ph, qh.first) && qh.length == p.length
		qh << char
    if qh.matches?(ph, char)
      tracker += 1
      answer << idx - p.length + 1 if tracker == num_uniqs
    end
  end

  answer
end

p find_anagrams('abacbabc', 'abc')
