import math


class Task4:
	def __init__(self, data, y):
		self.data_list = data
		self.column_number = y
		self.mean = 0
		self.sigma = 0

	def calculate_mean(self):
		summation = 0
		for elements in self.data_list:
			summation += elements[self.column_number]
		self.mean = summation / len(self.data_list)
		return self.mean

	def calculate_sigma(self):
		if len(self.data_list) == 0:
			return 0
		summation = 0
		for elements in self.data_list:
			summation += ((elements[self.column_number] - self.mean) * (elements[self.column_number] - self.mean))
		self.sigma = math.sqrt(summation / (len(self.data_list)-1))
		return math.pow(self.sigma, 2)


def load_data_set(filename):
	input_file = open(filename, "r")
	unique_labels = []
	dictionary = {}
	for line in input_file:
		row_list = (line.split(" "))
		row_list = list(filter(None, row_list))
		row_list = list(map(float, row_list))
		if row_list[-1] in dictionary:
			dictionary[row_list[-1]].append(row_list[0: -1])
		else:
			unique_labels.append(row_list[-1])
			dictionary[row_list[-1]] = [row_list[0: -1]]
	return dictionary, unique_labels


def main():
	file_path = input()
	dic, unique_labels = load_data_set(file_path)
	unique_labels = sorted(unique_labels)
	for label in range(0, len(unique_labels)):
		for dimension in range(0, len(dic[unique_labels[label]][0])):
			task4 = Task4(dic[unique_labels[label]], dimension)
			mean = task4.calculate_mean()
			sigma = task4.calculate_sigma()
			print("Class %d" % unique_labels[label], " dimension ", dimension + 1, " mean = %.2f" % mean, " variance = %.2f" % sigma)

main()
