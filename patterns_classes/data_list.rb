class DataList
	attr_accessor :sorted_array
	private :sorted_array, :sorted_array=

	def initialize(array)
		#так как изначально сортировка от меньшего к большему
		self.sorted_array = array.sort{|a, b| a <=> b}
	end
	def [](index)
		self.sorted_array[index]
	end

	def to_s
		self.sorted_array.to_s
	end
end