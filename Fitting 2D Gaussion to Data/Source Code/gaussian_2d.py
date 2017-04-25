import math


class Task4:
	def __init__(self, data):
		self.data_list = data

	def calculate_mean(self, column_number):
		summation = 0
		for elements in self.data_list:
			summation += elements[column_number]
		mean = summation / len(self.data_list)
		return mean

	def calculate_variance(self, column_number, mean):
		if len(self.data_list) == 0:
			return 0
		summation = 0
		for elements in self.data_list:
			summation += math.pow((elements[column_number] - mean), 2)
		sigma = math.sqrt(summation / (len(self.data_list) - 1))
		return math.pow(sigma, 2)

	def calculate_covariance(self, column1, column2, mean1, mean2):
		if len(self.data_list) == 0:
			return 0
		summation = 0
		for elements in self.data_list:
			summation += (elements[column1]-mean1) * (elements[column2]-mean2)
		sigma = summation / (len(self.data_list) - 1)
		return sigma


def load_data_set(filename):
	input_file = open(filename, "r")
	unique_labels = []
	dictionary = {}
	for line in input_file:
		row_list = (line.split(" "))
		row_list = list(filter(None, row_list))
		row_list = list(map(float, row_list))
		if row_list[-1] in dictionary:
			dictionary[row_list[-1]].append(row_list[0: 2])
		else:
			unique_labels.append(row_list[-1])
			dictionary[row_list[-1]] = [row_list[0: 2]]
	return dictionary, unique_labels


def main():
	file_path = input()
	dic, unique_labels = load_data_set(file_path)
	unique_labels.sort()
	for label in unique_labels:
		task4 = Task4(dic[label],)
		column_mean1 = task4.calculate_mean(0)
		column_mean2 = task4.calculate_mean(1)
		sigma1 = task4.calculate_variance(0, column_mean1)
		sigma2 = task4.calculate_covariance(0, 1, column_mean1, column_mean2)
		sigma4 = task4.calculate_variance(1, column_mean2)
		print("Class %d" % label, " mean = [ %.2f" % column_mean1, " %.2f" % column_mean2, "], sigma = [ %.2f" % sigma1, " %.2f" % sigma2, " %.2f" % sigma2, " %.2f]" % sigma4)

main()
