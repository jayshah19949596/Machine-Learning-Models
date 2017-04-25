import math


mean_dic = {}
sigma_dic = {}
weight_dic = {}
normal_dic = {}


class GaussianMixture:
	def __init__(self, train_file, test_file,  number_of_gaussians):
		self.classifier_dic = {}
		self.mean_dic = {}
		self.variance_dic = {}
		self.normal_dic = []
		self.unique_labels = []
		self.probability_dic = {}
		self.data_dic = {}
		self.total_training_object = 0
		self.train_file = train_file
		self.test_file = test_file
		self.number_of_gaussians = number_of_gaussians

	def train(self):
		""" Trains the mixture of gaussian naive bayes classifier """
		
		number_of_gaussians = self.number_of_gaussians
		train_file_path = self.train_file
		data_dic, self.unique_labels, total_number_of_rows, data_list = load_data_set(train_file_path)
		self.total_training_object = total_number_of_rows
		self.unique_labels = list(map(int, self.unique_labels))
		self.unique_labels = sorted(self.unique_labels)
		self.data_dic = data_dic
		train_mixture = GaussianMixtureTraining(number_of_gaussians, data_dic)
		for label in data_dic:
			mean_dic[label] = {}
			sigma_dic[label] = {}
			weight_dic[label] = {}
			for col in range(0, len(data_dic[label][0])):
				mean, sigma, weight = train_mixture.initialise_parameters(col, label)
				mean_dic[label][col] = mean
				sigma_dic[label][col] = sigma
				weight_dic[label][col] = weight

		for x in range(0, 50):
			train_mixture.e_step()
			train_mixture.m_step()

		for label in data_dic:
			for col in range(0, len(data_dic[label][0])):
				for gaussian in range(0, number_of_gaussians):
					print("Class %d, attribute %d, Gaussian %d, mean = %.2f, std = %.2f" % (label, col, gaussian, mean_dic[label][col][gaussian], sigma_dic[label][col][gaussian]))

	def test(self):
		""" performs testing on test data """
		
		number_of_gaussians = self.number_of_gaussians
		test_file = self.test_file
		number_of_test_row, test_data = load_test_set(test_file)
		probability_dic = self.probability_of_classifiers()
		mixture_classify = GaussianMixtureClassification(test_data, self.data_dic, number_of_gaussians, probability_dic, number_of_test_row)
		for row in test_data:
			mixture_classify.classification(row)
		mixture_classify.display_accuracy()

	def probability_of_classifiers(self):
		"""Calculates probability of class labels
				
				Returns
				------------------------------------------------------
				probability_dic      : dictionary
						       class labels are key and their probabilities are dictionary
				"""
		probability_dic = {}
		for labels in self.unique_labels:
			probability = len(self.data_dic[labels]) / float(self.total_training_object)
			probability_dic[labels] = probability
		return probability_dic


class GaussianMixtureClassification:
	def __init__(self, test_data, data_dic, number_of_gaussians, probability_dic, total_test_rows):
		self.test_data = test_data
		self.data_dic = data_dic
		self.number_of_gaussians = number_of_gaussians
		self.probability_dic = probability_dic
		self.classifier_dic = {}
		self.accuracy_count = 0
		self.total_tes_rows = total_test_rows

	def classification(self, test_row):
		data_structure = {}
		for label in self.data_dic:
			for col in range(0, len(self.test_data[0][0:-2])):
				for gaussian in range(0, self.number_of_gaussians):
					pdf = GaussianMixtureTraining.calculate_normal(test_row[col], label, col, gaussian)
					pdf *= weight_dic[label][col][gaussian]
					if label in data_structure:
						if col in data_structure[label]:
							if gaussian in data_structure[label][col]:
								data_structure[label][col][gaussian] = pdf
							else:
								data_structure[label][col][gaussian] = pdf
						else:
							gaussian_dic = {}
							gaussian_dic[gaussian] = pdf
							data_structure[label][col] = gaussian_dic
					else:
						gaussian_dic = {}
						gaussian_dic[gaussian] = pdf
						col_dic = {}
						col_dic[col] = gaussian_dic
						data_structure[label] = col_dic
		data_struct = {}
		for label in self.data_dic:
			for col in range(0, len(self.test_data[0][0:-2])):
				for gaussian in range(0, self.number_of_gaussians):
					if label in data_struct:
						if col in data_struct[label]:
							data_struct[label][col] = data_struct[label][col] + data_structure[label][col][gaussian]
						else:
							data_struct[label][col] = data_structure[label][col][gaussian]
					else:

						data_struct[label] = {col: data_structure[label][col][gaussian]}
		posterior = {}
		for label in self.data_dic:
			for col in range(0, len(self.test_data[0][0:-2])):
				if label in posterior:
					posterior[label] = posterior[label] * data_struct[label][col]
				else:
					posterior[label] = data_struct[label][col] * self.probability_dic[label]
		summation = 0
		for label in posterior:
			summation += posterior[label]
		for label in posterior:
			if summation == 0:
				summation = 0.1
			posterior[label] /= (float(summation))
		maximum = -9999
		for label in posterior:
			if posterior[label] > maximum:
				maximum = posterior[label]
				predicted = label

		accuracy = 0
		if predicted == test_row[-2]:
			accuracy = 1
		self.accuracy_count += accuracy
		print("ID=%5d, predicted=%3d, probability = %.4lf, true=%3d, accuracy=%4.2lf" % (test_row[-1], predicted, maximum, test_row[-2], accuracy))

	def display_accuracy(self):
		print("classification accuracy=%6.4lf" % (self.accuracy_count / float(self.total_tes_rows)))


class GaussianMixtureTraining:
	def __init__(self, number_of_gaussians, data_dic):
		self.number_of_gaussians = number_of_gaussians
		self.data_dic = data_dic

	def initialise_parameters(self, column_number, label):
		mean = {}
		sigma = {}
		weight = {}
		maximum = -1
		minimum = 99999
		for row in self.data_dic[label]:
			if row[column_number] > maximum:
				maximum = row[column_number]
			elif row[column_number] < minimum:
				minimum = row[column_number]
		g = (maximum - minimum) / float(self.number_of_gaussians)
		for x in range(0, self.number_of_gaussians):
			mean[x] = minimum + x*g + g/2.0
			sigma[x] = 1
			weight[x] = 1.0/self.number_of_gaussians
		return mean, sigma, weight

	def e_step(self):
		""" Updates the normal distribution of every element in the training data """
		
		for label in self.data_dic:
			for col in range(len(self.data_dic[label][0])):
				for row in range(0, len(self.data_dic[label])):
					summation = 0.0
					for gaussian in range(0, self.number_of_gaussians):
						pdf = GaussianMixtureTraining.calculate_normal(self.data_dic[label][row][col], label, col, gaussian)
						pdf *= weight_dic[label][col][gaussian]
						summation += pdf
						if label in normal_dic:
							if col in normal_dic[label]:
								if row in normal_dic[label][col]:
									if gaussian in normal_dic[label][col][row]:
										normal_dic[label][col][row][gaussian] = pdf
									else:
										normal_dic[label][col][row][gaussian] = pdf
								else:
									normal_dict1 = {}
									normal_dict1[gaussian] = pdf
									normal_dic[label][col][row] = normal_dict1

							else:
								normal_dict1 = {}
								normal_dict1[gaussian] = pdf
								normal_dict2 = {}
								normal_dict2[row] = normal_dict1
								normal_dic[label][col] = normal_dict2

						else:
							normal_dict3 = {}
							normal_dict3[gaussian] = pdf
							normal_dict4 = {}
							normal_dict4[row] = normal_dict3
							normal_dict5 = {}
							normal_dict5[col] = normal_dict4
							normal_dic[label] = normal_dict5

					for gaussian in range(0, self.number_of_gaussians):
						normal_dic[label][col][row][gaussian] = float(normal_dic[label][col][row][gaussian] / summation)

	def m_step(self):
		""" Updates mean, sigma, and weights of of every gaussian for every dimension for every training data"""
		
		for label in self.data_dic:
			for col in range(0, len(self.data_dic[label][0])):
				for gaussian in range(0, self.number_of_gaussians):
					numerator = 0
					denominator = 0
					for row in range(0, len(self.data_dic[label])):
						numerator += normal_dic[label][col][row][gaussian] * self.data_dic[label][row][col]
						denominator += normal_dic[label][col][row][gaussian]
					mean_dic[label][col][gaussian] = numerator / denominator

				for gaussian in range(0, self.number_of_gaussians):
					numerator = 0
					denominator = 0
					for row in range(0, len(self.data_dic[label])):
						numerator += normal_dic[label][col][row][gaussian] * (math.pow((self.data_dic[label][row][col] - mean_dic[label][col][gaussian]), 2))
						denominator += normal_dic[label][col][row][gaussian]
					sigma_dic[label][col][gaussian] = math.sqrt(numerator / denominator)
				denominator = 0
				for gaussian in range(0, self.number_of_gaussians):
					for row in range(0, len(self.data_dic[label])):
						denominator += normal_dic[label][col][row][gaussian]
				for gaussian in range(0, self.number_of_gaussians):
					numerator = 0
					for row in range(0, len(self.data_dic[label])):
						numerator += normal_dic[label][col][row][gaussian]
					weight_dic[label][col][gaussian] = numerator / denominator

	@staticmethod
	def calculate_normal(value, label, col, gaussian):
		"""Calculates normal distribution

			Parameters
			------------------------------------------------------
			value     :    float
				       value of x in f(x)
			label     :    float
				       class label
			col       :    int
			      	       dimension number
			gaussian  :    int
				       gaussian number

			Returns
			------------------------------------------------------
			normal : float
					 normal distribution over a dimension.
		"""
		if sigma_dic[label][col][gaussian] < 0.01:
			sigma_dic[label][col][gaussian] = 0.01
		sigma = sigma_dic[label][col][gaussian]
		denominator = sigma * math.sqrt(2*math.pi)
		power = ((-1)*math.pow((value - mean_dic[label][col][gaussian]), 2)) / float((2*sigma*sigma))
		numerator = math.pow(math.e, power)
		normal = numerator / float(denominator)
		return normal


def load_data_set(filename):
	"""Loads the training data from a file to the dictionary

		Parameters
		------------------------------------------------------
		filename   :   string
			       File path of training data

		Returns
		------------------------------------------------------
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
	""""Loads the testing data from a file to the dictionary

		Parameters
		------------------------------------------------------
		filename   :   string
		      	       file path of training data

		Returns
		------------------------------------------------------
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
		data_list.append(row_list+[loop_count])
		loop_count += 1
	return loop_count, data_list


def main():

	input_line = input()							# Taking file path from user as input
	input_list = input_line.split()  					# converting  the input to a list

	gaussian_mixture = GaussianMixture(input_list[1], input_list[2], int(input_list[4]))
	gaussian_mixture.train()
	gaussian_mixture.test()


main()
