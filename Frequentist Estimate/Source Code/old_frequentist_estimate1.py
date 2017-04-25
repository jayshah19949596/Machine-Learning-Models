import numpy as np
import time


class Task1:

	def __init__(self):
		"""This Function initialises the random uniform array and the string"""
		
		self.randUniformArray = np.random.uniform(0, 1, 3100)
		self.string = ""

	def form_string(self):
		""" This Function will form the string which will contain a and b """
		
		for x in range(0, 3100):
			if self.randUniformArray[x] > 0.1:
				self.string += "b"
			else:
				self.string += "a"

	def probability_of_character(self, character):
		""" This function calculates the probability of occurrence of certain character in the string """
		
		count_of_character = self.string.count(character)
		count_of_character = float(count_of_character)
		probability = count_of_character/len(self.string)
		return probability

if __name__ == "__main__":
	# start = time.time()
	task1 = Task1()
	task1.form_string()
	solution1 = task1.probability_of_character("a")
	print("p(c = 'a') = %.4f" % solution1)
	# end = time.time()
	# print("time", end - start)

