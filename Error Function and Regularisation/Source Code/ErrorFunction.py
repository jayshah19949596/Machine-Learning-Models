import numpy as np


class ErrorFunction:

	def __init__(self, w_vector, in_vector, out_vector):
		self.coEfficientVector = w_vector
		self.inVec = in_vector
		self.outVec = out_vector
		self.w_magnitude = 0

	def calculate_y(self):
		"""
		This Function calculate_y takes takes two numpyArray as argument and
		calculates y(xi, w) = w1 * xi, 1 + w2 * xi, 2 + w3 * xi, 3.
		sumOfRows = y(xi, w) and returns sumOfRows
		"""
	
		vector = self.coEfficientVector * self.inVec
		sum_of_rows = vector.sum(axis=1)
		return sum_of_rows
	
	def calculate_sum_of_difference_of_square(self, y_vector):
		"""
		This Function calculate_sum_of_difference_of_square takes takes two numpyArray as argument and
		calculates E(w) = (1/2) {∑n=1 [y(xn, w) – tn] ^ 2 }
		sumOfRows = y(xi, w) and returns sumOfRows
		"""
		
		sum_of_difference = y_vector - self.outVec
		sum_of_difference = np.square(sum_of_difference)
		summation_first = sum_of_difference.sum()
		summation_first /= 2
		return summation_first

	def calculate_w_magnitude(self):
		"""
		This function calculate_w_magnitude calculates the magnitude of the co-efficient vector
		it takes co-efficient vector as argument and returns a number which is the magnitude of the coefficient vector
		basically ||w||^2 is calculated over here by calculate_W_Magnitude function
		"""
		
		self.coEfficientVector = np.square(self.coEfficientVector)
		self.w_magnitude = self.coEfficientVector.sum()
		print("wMagnitude", self.w_magnitude)

	def calculate_regularisation_term(self, lambda_variable):
		"""
		This function calculate_w_magnitude calculates the magnitude of the co-efficient vector
		it takes co-efficient vector as argument and returns a number which is the magnitude of the coefficient vector
		basically ||w||^2 is calculated over here by calculate_W_Magnitude function
		"""
		half_lambda_variable = lambda_variable / 2
		regularisation_term = half_lambda_variable * self.w_magnitude
		print("regularisationTerm", regularisation_term)
		return regularisation_term

	@staticmethod
	def regularisation(first_term, second_term):
		return first_term + second_term


def load_data_set(filename):
	"""
	This Function load_data_set takes filename as argument and reads the data from the filename and stores
	it in a list
	"""
	
	input_file = open(filename, "r")
	line_list = []
	loop_count = 0
	for line in input_file:
		loop_count += 1
		line = line.strip('\n')
		row_list = (line.split("    "))
		row_list = list(map(float, row_list))
		line_list.append(row_list)
	return line_list, loop_count


def insert_in_array(list_vector, count, number):
	"""This Function insert_in_array takes list, countOfLoops of load data set function, number
	as argument and stores the list elements into the Numpy Array and returns that Numpy Array
	"""
	
	if number == 1:
		data_numpy = np.reshape(list_vector, count)
	else:
		data_numpy = np.reshape(list_vector, (count, number))
	return data_numpy


def main():
	in_list_vector, row_count = load_data_set("training_inputs1.txt")
	out_list_vector, row_count = load_data_set("training_outputs1.txt")
	in_data_vector = insert_in_array(in_list_vector, row_count, 3)
	out_data_vector = insert_in_array(out_list_vector, row_count, 1)
	'''===================================================================='''
	task1 = ErrorFunction(np.array((3, -1.5, -2)), in_data_vector, out_data_vector)
	y_vector = task1.calculate_y()
	err_func1 = task1.calculate_sum_of_difference_of_square(y_vector)
	print("E(w) = (1/2) {∑n=1 [y(xn, w) – tn] ^ 2 } = ", err_func1)
	'''===================================================================='''
	task2 = ErrorFunction(np.array((5.2, -2, 1)), in_data_vector, out_data_vector)
	y_vector = task2.calculate_y()
	err_func2 = task2.calculate_sum_of_difference_of_square(y_vector)
	print("E(w) = (1/2) {∑n=1 [y(xn, w) – tn] ^ 2 } = ", err_func2)
	'''===================================================================='''
	task1.calculate_w_magnitude()
	second_term1 = task1.calculate_regularisation_term(0.25)
	err_func_regularised = task1.regularisation(err_func1, second_term1)
	print("E(w) = (1/2) {∑n=1 [y(xn, w) – tn] ^ 2}+  [(1/2)(λ)(||w||^2)] = ", err_func_regularised)
	'''===================================================================='''
	task2.calculate_w_magnitude()
	second_term2 = task2.calculate_regularisation_term(0.25)
	err_func_regularised = task1.regularisation(err_func2, second_term2)
	print("E(w) = (1/2) {∑n=1 [y(xn, w) – tn] ^ 2}+  [(1/2)(λ)(||w||^2)] = ", err_func_regularised)


main()
