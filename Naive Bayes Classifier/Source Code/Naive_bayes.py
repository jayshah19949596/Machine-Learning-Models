import math
"""
Program performs naive bayes classifier on numerical data
"""

class Histogram:
	def __init__(self, train_file, test_file, number_of_gaussians):
		self.classifier_dic = {}
		self.probability_dic = {}
		self.column_bin_dic = {}
		self.unique_labels = []
		self.train_file = train_file
		self.test_file = test_file
		self.number_of_gaussians = number_of_gaussians

	def train(self):
		""" Trains the naive bayes classifier """
		
		train_file_path = self.train_file
		number_of_bins = self.number_of_gaussians
		data_dic, self.unique_labels, total_number_of_rows, data_list = load_data_set(train_file_path)
		self.unique_labels = sorted(self.unique_labels)
		self.unique_labels = list(map(int, self.unique_labels))
		total_number_of_columns = len(data_list[0]) - 1
		bin_range_dic = {}
		column_bin_dic = {}
		histogram_training = HistogramTraining
		for x in range(0, total_number_of_columns):
			for label in data_dic:
				bin_list, bin_range = histogram_training.bining(x, number_of_bins, data_dic[label])
				if label in column_bin_dic:
					column_bin_dic[label][x] = bin_list
					bin_range_dic[label][x] = bin_range
				else:
					col_dic = {}
					range_dic = {}
					col_dic[x] = bin_list
					range_dic[x] = bin_range
					column_bin_dic[label] = col_dic
					bin_range_dic[label] = range_dic
		self.column_bin_dic = column_bin_dic
		data_dic = histogram_training.change_data(column_bin_dic, data_dic)
		self.probability_dic = histogram_training.probability_of_classifiers(self.unique_labels, total_number_of_rows, data_dic)
		self.classifier_dic = histogram_training.calculate_conditional_probability(data_dic, number_of_bins, bin_range_dic)

	def test(self):
		""" performs testing on test data """
		
		test_file_path = self.test_file
		number_of_test_rows, test_data = load_test_set(test_file_path)
		classification = HistogramClassification(self.probability_dic, self.classifier_dic, self.column_bin_dic, self.unique_labels, self.column_bin_dic)
		for row in test_data:
			classification.classify(row)
		classification.display_accuracy(number_of_test_rows)


class HistogramTraining:
	data_dic = {}

	@staticmethod
	def bining(column_number, total_bins, data_list):
		""" performs binning on given dimension
			Parameters
			--------------------------------------------------
			column_number :    int
					   dimension number
			total_bins    :    int
				           number of bins to be created
			data_list     :    list
					   list of training data


		    	Returns
		    	--------------------------------------------------
			bin_list  : list
		                    list of list containing the range of the bin for the given dimension
		    	bin_range : float
		    		    range for each bin in binning
		"""
		
		bin_list = []
		if total_bins == 1:
			bin_list.append([-1, 9999])
			return bin_list, 0
		maximum = 0
		minimum = 99999
		for row in data_list:
			if row[column_number] > maximum:
				maximum = row[column_number]
			elif row[column_number] < minimum:
				minimum = row[column_number]
		bin_range = (maximum - minimum) / float((total_bins-3))
		x = 0
		for y in range(2, total_bins-1):
			bin_list.append([minimum + x*bin_range + (bin_range/2.0), minimum + (x+1)*bin_range + (bin_range/2.0)])
			x += 1
		bin_list.insert(0, [-999, minimum - (bin_range / 2.0)])
		bin_list.insert(1, [minimum - (bin_range / 2.0), minimum + (bin_range / 2.0)])
		bin_list.append([minimum + x * bin_range + (bin_range/2.0), 9999.0])
		return bin_list, bin_range

	@staticmethod
	def change_data(column_bin_dic, data_dic):
		""" changes the data to the bin number indicating which bin does the data goes in
		
			Parameters
			--------------------------------------------------
			column_bin_dic :    dictionary

			data_dic       :    dictionary
							    
		    	Returns
		   	--------------------------------------------------
			data_dic  : dictionary
		                
		"""
		
		for labels in data_dic:
			for column in range(0, len(data_dic[labels][0])):
				for row in data_dic[labels]:
					index = 0
					for bin_range in column_bin_dic[labels][column]:
						if (row[column] >= bin_range[0]) and (row[column] < bin_range[1]):
							row[column] = index
							break
						index += 1
		return data_dic

	@staticmethod
	def probability_of_classifiers(unique_labels, total_number_of_rows, data_dic):
		"""Calculates probability of class labels

		Parameters
		--------------------------------------------------
		unique_labels        :    list
					  contains list of unique class labels.
		total_number_of_rows :    int
					  number of samples in the training data
		data_dic	     :    dictionary

		Returns
		--------------------------------------------------
		probability_dic      : 	dictionary
					class labels are key and their probabilities are dictionary
		"""
		probability_dic = {}
		for labels in unique_labels:
			probability = len(data_dic[labels]) / float(total_number_of_rows)
			probability_dic[labels] = probability
		return probability_dic

	@staticmethod
	def add_to_dictionary(probability, label, column, column_value, classifier_dic):
		if column in classifier_dic:
			if column_value in classifier_dic[column]:
				if label in classifier_dic[column][column_value]:
					classifier_dic[column][column_value][label] = probability
				else:
					inside_dic = {}
					inside_dic[label] = probability
					classifier_dic[column][column_value][label] = probability
			else:
				out_dic = {}
				inside_dic = {}
				inside_dic[label] = probability
				out_dic[column_value] = inside_dic
				classifier_dic[column][column_value] = inside_dic
		else:
			outer_dic = {}
			out_dic = {}
			inside_dic = {}
			inside_dic[label] = probability
			out_dic[column_value] = inside_dic
			outer_dic[column] = out_dic
			classifier_dic[column] = out_dic
		return classifier_dic

	@staticmethod
	def calculate_conditional_probability(data_dic, number_of_bins, bin_range):
		"""calcualtes the conditional probability of P(bin|class)

		Parameters
		--------------------------------------------------
		data_dic        :    dictionary
					         
		number_of_bins  :    int
				     number of bins for the dimension
		bin_range       :    int
				     bin range of the dimension
					         
		Returns
		--------------------------------------------------
		classifier_dic	: dictionary
		"""
		
		classifier_dic = {}
		for labels in data_dic:
			for column in range(0, len(data_dic[labels][0])):
				bin_count = {}
				row_count = 0
				for row in data_dic[labels]:
					if row[column] in bin_count:
						bin_count[row[column]] += 1
					else:
						bin_count[row[column]] = 1
					row_count += 1
				for bins in range(0, number_of_bins):
					if bins in bin_count:
						if bin_range[labels][column] == 0:
							bin_range[labels][column] = 0.1
						pro = (bin_count[bins] / (float(row_count) * bin_range[labels][column]))
						print("Class %d, attribute %d, bin %d, P(bin | class) = %.2f" % (labels, column, bins, pro))
						classifier_dic = HistogramTraining.add_to_dictionary(pro, labels, column, bins, classifier_dic)
					else:
						print("Class %d, attribute %d, bin %d, P(bin | class) = %.2f" % (labels, column, bins, 0 / row_count))
						classifier_dic = HistogramTraining.add_to_dictionary(0, labels, column, bins, classifier_dic)
		return classifier_dic


class HistogramClassification:
	def __init__(self, probability_dic, classifier_dic, column_dic, unique_labels, column_bin_dic):
		self.probability_dic = probability_dic
		self.classifier_dic = classifier_dic
		self.column_dic = column_dic
		self.unique_labels = unique_labels
		self.correctly_classifed = 0
		self.column_bin_dic = column_bin_dic

	def classify(self, data_row):
		"""classifies a new data

		Parameters
		----------
		data_row 	:    list
				         contains unknown data to be classified
		"""
		
		result = {}
		for label in self.unique_labels:
			for column in range(0, len(data_row)-2):
				data = data_row[0:]
				index = 0
				for bin_range in self.column_bin_dic[label][column]:
					if (data[column] >= bin_range[0]) and (data[column] < bin_range[1]):
						data[column] = index
						break
					index += 1
				if label in result:
					result[label] *= self.classifier_dic[column][data[column]][label]
				else:
					result[label] = self.classifier_dic[column][data[column]][label] * self.probability_dic[label]
		summation = sum(result.values())
		for label in result:
			if summation == 0:
				break
			result[label] /= float(summation)
		maximum = -9999
		for label in result:
			if result[label] > maximum:
				predicted = label
				maximum = result[label]

		accuracy = 0
		if predicted == data_row[-2]:
			accuracy = 1
		self.correctly_classifed += accuracy
		print("ID = %5d, predicted = %3d, probability = %.4f, true=%3d, accuracy=%4.2f" % (data_row[-1], predicted, result[predicted], data_row[-2], accuracy))

	def display_accuracy(self, number_of_test_rows):
		print("classification accuracy=%6.4lf" % (self.correctly_classifed / float(number_of_test_rows)))


def load_data_set(filename):
	"""Loads the training data from a file to the dictionary

		Parameters
		--------------------------------------------------
		filename   :   string
			       file path of training data

		Returns
		--------------------------------------------------
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
			       File path of training data

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
		data_list.append(row_list+[loop_count])
		loop_count += 1
	return loop_count, data_list


def main():
	
	input_line = input()  							# Taking file path from user as input
	input_list = input_line.split()  					# converting  the input to a list

	histogram = Histogram(input_list[1], input_list[2], int((input_list[4])))
	histogram.train()
	histogram.test()

main()
