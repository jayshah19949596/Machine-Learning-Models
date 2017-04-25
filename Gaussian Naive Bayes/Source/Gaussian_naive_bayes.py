import math
"""
Program fits the training data to a gaussian model
"""


class Gaussian:
	def __init__(self, train_file, test_file):
		self.classifier_dic = {}
		self.mean_dic = {}
		self.variance_dic = {}
		self.normal_dic = []
		self.unique_labels = []
		self.probability_dic = {}
		self.train_file = train_file
		self.test_file = test_file

	def train(self):
		""" Trains the gaussian naive bayes classifier """

		train_file_path = self.train_file
		data_dic, self.unique_labels, total_number_of_rows, data_list = load_data_set(train_file_path)
		self.unique_labels = list(map(int, self.unique_labels))
		self.unique_labels = sorted(self.unique_labels)
		for label in self.unique_labels:
			for dimension in range(0, len(data_dic[label][0])):
				gaussian_training = GaussianTraining(data_dic[label], dimension)
				mean = gaussian_training.calculate_mean()
				variance = gaussian_training.calculate_variacne()
				if variance < 0.0001:
					variance = 0.0001
				if label in self.mean_dic:
					self.mean_dic[label].append(mean)
					self.variance_dic[label].append(variance)
				else:
					self.mean_dic[label] = [mean]
					self.variance_dic[label] = [variance]
				print("Class %d, dimension %d, mean = %.2f, std = %.2f" % (
				label, dimension + 1, mean, math.sqrt(variance)))
		self.probability_dic = GaussianTraining.probability_of_classifiers(self.unique_labels, total_number_of_rows, data_dic)

	def test(self):
		""" performs testing on test data """

		test_file_path = self.test_file
		number_of_test_rows, test_data = load_test_set(test_file_path)
		classification = GaussianClassification(self.unique_labels, self.mean_dic, self.variance_dic, self.probability_dic)
		for row in test_data:
			classification.classify(row)

		classification.display_accuracy(number_of_test_rows)


class GaussianTraining:
	def __init__(self, data, y):
		self.data_list = data
		self.column_number = y
		self.mean = 0
		self.sigma = 0
		self.variance = 0

	def calculate_mean(self):
		""" Calculates mean of the given dimension

        Returns
        -------
        self.mean : float
                    mean over the given dimension
        """

		summation = 0
		for elements in self.data_list:
			summation += elements[self.column_number]
		self.mean = summation / len(self.data_list)
		return self.mean

	def calculate_variacne(self):
		""" Calculates mean of the given dimension

		Returns
		-------
		self.variance : float
						variance over the given dimension
        """
		
		if len(self.data_list) == 0:
			return 0
		summation = 0
		for elements in self.data_list:
			summation += ((elements[self.column_number] - self.mean) * (elements[self.column_number] - self.mean))
		self.sigma = math.sqrt(summation / (len(self.data_list) - 1))
		self.variance = math.pow(self.sigma, 2)
		return self.variance

	def calculate_normal_distribution(self, label):
		"""Calculates normal distribution

		Parameters
		----------
		label : int
				Class label.
	
		Returns
		-------
		normal : float
				 normal distribution over a dimension for a class label.
		"""
		
		if self.variance == 0:
			return 0
		denominator = self.sigma * (math.sqrt(2 * math.pi))
		power = ((-1) * math.pow((label - self.mean), 2)) / (2 * self.variance)
		numerator = math.pow(math.e, power)
		normal = numerator / denominator
		return normal

	@staticmethod
	def probability_of_classifiers(unique_labels, total_number_of_rows, data_dic):
		"""Calculates probability of class labels

		Parameters
		----------
		unique_labels        :    list
					              contains list of unique class labels.
		total_number_of_rows :    int
								  number of samples in the training data
		data_dic			 :    dictionary
				
		Returns
		-------
		probability_dic      : dictionary
							   class labels are key and their probabilities are dictionary
		"""
		
		probability_dic = {}
		for labels in unique_labels:
			probability = len(data_dic[labels]) / float(total_number_of_rows)
			probability_dic[labels] = probability
		return probability_dic


class GaussianClassification:
	def __init__(self, unique_labels, mean, variance, probability_dic):
		self.unique_labels = unique_labels
		self.mean_dic = mean
		self.variance_dic = variance
		self.normal_dic = {}
		self.probability_dic = probability_dic
		self.correctly_classifed = 0
		self.total_probability = {}

	def classify(self, data_row):
		"""classifies a new data

		Parameters
		----------
		data_row        :    list
					         contains unknown data to be classified
		"""
		self.normal_dic = {}
		for label in self.unique_labels:
			for column in range(0, len(data_row) - 2):
				normal_result = self.calculate_normal_distribution(data_row[column], self.mean_dic[label][column], self.variance_dic[label][column])
				if label in self.normal_dic:
					self.normal_dic[label] *= normal_result
				else:
					self.normal_dic[label] = normal_result
		maximum = -1
		for label in self.normal_dic:
			self.normal_dic[label] = (self.normal_dic[label] * self.probability_dic[label])
		denominator = sum(self.normal_dic.values())
		for label in self.normal_dic:
			self.normal_dic[label] /= (float(denominator))
			if maximum < self.normal_dic[label]:
				maximum = self.normal_dic[label]
				classified_as = label

		accuracy = 0
		if classified_as == data_row[-2]:
			self.correctly_classifed += 1
			accuracy = 1
		print("ID = %5d, predicted = %3d, probability = %.4f, true=%3d, accuracy=%4.2f" % (
		data_row[-1], classified_as, maximum, data_row[-2], accuracy))

	def display_accuracy(self, number_of_test_rows):
		print("classification accuracy=%6.4lf " % (self.correctly_classifed / float(number_of_test_rows)))

	@staticmethod
	def calculate_normal_distribution(value, mean, variance):
		"""Calculates normal distribution

				Parameters
				----------
				value   :   float
						    value of x in f(x)
				mean    :   float
						    mean of the dimension
				variance :  float
				            variance of the dimension

				Returns
				-------
				normal : float
						 normal distribution over a dimension.
		"""
		if variance < 0.0001:
			variance = 0.0001
		denominator = math.sqrt(variance * 2 * math.pi)

		power = ((-1) * math.pow((value - mean), 2)) / float((2 * variance))
		numerator = math.pow(math.e, power)
		normal = numerator / float(denominator)

		return normal


def load_data_set(filename):
	"""Loads the training data from a file to the dictionary

		Parameters
		----------
		filename   :   string
			       	   file path of training data
							       
		Returns
		-------
		dictionary    : dictionary
				        class label as key : list of rows as value
		unique_labels : list
		 				list of unique labels in the training data
		loop_count    : int
						number of training samples
		data_list     : list
						list of training data
	"""
	data_list = []
	input_file = open(filename, "r")
	unique_labels = []
	dictionary = {}
	loop_count = 0
	for line in input_file:
		row_list = (line.split(" "))
		row_list = list(filter(None, row_list))
		row_list = list(map(float, row_list))
		data_list.append(row_list)
		if row_list[-1] in dictionary:
			dictionary[row_list[-1]].append(row_list[0:-1])
		else:
			unique_labels.append(row_list[-1])
			dictionary[row_list[-1]] = [row_list[0:-1]]
		loop_count += 1
	return dictionary, unique_labels, loop_count, data_list


def load_test_set(filename):
	"""Loads the testing data from a file to the dictionary

		Parameters
		----------
		filename   :   string
				       file path of training data
							       
		Returns
		-------
		loop_count    : int
						number of training samples
		data_list     : list
						list of training data
	"""
	data_list = []
	input_file = open(filename, "r")
	loop_count = 0
	for line in input_file:
		row_list = (line.split(" "))
		row_list = list(filter(None, row_list))
		row_list = list(map(float, row_list))
		data_list.append(row_list + [loop_count])
		loop_count += 1
	return loop_count, data_list


def main():
	
	input_line = input()			 					# Taking file path from user as input
	input_list = input_line.split()  					# converting  the input to a list

	gaussian = Gaussian(input_list[1], input_list[2])   # making object of Gaussian
	gaussian.train()
	gaussian.test()
	

main()
