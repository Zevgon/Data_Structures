from heap_dict import HeapDict
from collections import deque

class MedianQueue:
	def __init__(self, max_len, prc = lambda x: x):
		self.min_heap = HeapDict([], lambda x, y: x <= y, prc)
		self.max_heap = HeapDict([], lambda x, y: x >= y, prc)
		self.queue = deque()
		self.max_len = max_len
		self.prc = prc

	def adjust_heaps(self):
		lam = lambda heap: heap.len()
		while abs(self.min_heap.len() - self.max_heap.len()) > 1:
			shorter, longer = sorted([self.max_heap, self.min_heap], key = lam)
			shorter.insert(longer.extract())

	def empty(self):
		return not self.queue

	def insert(self, *items):
		for item in items:
			if self.maxed():
				remove_this = self.queue.popleft()
				if self.prc(remove_this) >= self.median():
					self.min_heap.delete(remove_this)
				else:
					self.max_heap.delete(remove_this)
			if self.empty():
				self.min_heap.insert(item)
			elif self.prc(item) >= self.median():
				self.min_heap.insert(item)
			else:
				self.max_heap.insert(item)
			self.queue.append(item)
			self.adjust_heaps()

	def maxed(self):
		return len(self.queue) >= self.max_len

	def median(self):
		if self.empty():
			return None
		elif self.min_heap.len() > self.max_heap.len():
			return self.prc(self.min_heap.peek())
		elif self.max_heap.len() > self.min_heap.len():
			return self.prc(self.max_heap.peek())
		else:
			return float(self.prc(self.max_heap.peek()) + self.prc(self.min_heap.peek())) / 2

	def show(self):
		print self.queue
		self.max_heap.show()
		self.min_heap.show()

mq = MedianQueue(4)
mq.insert(2, 2, 2, 2, 2, 2, 3, 3, 2, 5, 6, 1)
print mq.median()
