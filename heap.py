class Heap:
	def __init__(self, store = [], comparator = lambda x, y: x < y, prc = lambda x: x):
		self.store = store
		self.comparator = comparator
		self.prc = prc
		if self.store:
			self.heapify_store()

	def child_indices(self, idx):
		children = [(idx + 1) * 2 - 1, (idx + 1) * 2]
		return children

	def delete(self, idx):
		if idx < 0 or idx >= len(self.store):
			raise Exception('Cannot delete item: index out of range')
		last = len(self.store) - 1
		self.swap(idx, last)
		self.pop()
		self.heapify_up(idx)
		self.heapify_down(idx)

	def pop(self):
		self.store.pop()

	def empty(self):
		return not self.store

	def extract(self, num = 1):
		extracted_vals = []
		for x in range(0, num):
			if self.empty():
				return extracted_vals
			last_idx = len(self.store) - 1
			self.swap(0, last_idx)
			ret_val = self.store.pop()
			self.heapify_down()
			extracted_vals.append(ret_val)
		if len(extracted_vals) == 1:
			return extracted_vals[0]
		else:
			return extracted_vals

	def get_child_swap(self, idx):
		block = lambda child_idx: self.should_swap(idx, child_idx)
		options = filter(block, self.child_indices(idx))
		if len(options) == 0:
			return None
		elif len(options) == 1:
			return options[0]
		else:
			item1 = self.store[options[0]]
			item2 = self.store[options[1]]
			if self.comparator(self.prc(item1), self.prc(item2)):
				return options[0]
			else:
				return options[1]

	def heapify_down(self, idx = 0):
		swap_with = self.get_child_swap(idx)
		while swap_with:
			self.swap(idx, swap_with)
			idx = swap_with
			swap_with = self.get_child_swap(idx)

	def heapify_store(self):
		new_store = list(self.store)
		self.store = []
		for item in new_store:
			self.insert(item)

	def heapify_up(self, idx = None):
		if not idx:
			idx = len(self.store) - 1
		parent_idx = self.parent_idx(idx)
		while self.should_swap(parent_idx, idx):
			self.swap(parent_idx, idx)
			idx = parent_idx
			parent_idx = self.parent_idx(idx)

	def insert(self, *items):
		for item in items:
			self.store.append(item)
			self.heapify_up()

	ins = insert

	def parent_idx(self, idx):
		if idx % 2 == 0:
			return idx / 2 - 1
		else:
			return idx / 2

	def should_swap(self, parent_idx, idx):
		if idx >= len(self.store) or parent_idx < 0:
			return False
		parent = self.store[parent_idx]
		child = self.store[idx]
		return not self.comparator(self.prc(parent), self.prc(child))

	def show(self):
		print self.store

	def sort(self):
		old_store = list(self.store)
		result = []
		while not self.empty():
			result.append(self.extract())
		self.store = old_store
		return result

	def swap(self, parent_idx, idx):
		self.store[parent_idx], self.store[idx] = self.store[idx], self.store[parent_idx]


# h = Heap([8, 2, 4, 6, 7, 1, 2, 3], lambda x, y: x < y)
# h = Heap([], lambda x, y: x < y)
# h.ins(2, 5, 1, 6, 1, 7, 3, 2, 4, 81, 72)
# h.delete(6)
# print h.sort()
# h.show()
