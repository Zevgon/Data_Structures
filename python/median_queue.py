from heap import Heap

class MedianQueue:
	def __init__(self, max_len):
		self.min_heap = Heap()
		self.max_heap = Heap([], lambda x, y: x > y)
		self.queue = []
		self.dict = {}

	def insert(self, val):
		
